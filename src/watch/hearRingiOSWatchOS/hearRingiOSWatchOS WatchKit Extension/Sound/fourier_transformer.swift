//
//  fourier_transformer.swift
//  
//
//  Created by coes on 3/28/22.
//

import Foundation
import Accelerate
import AVFoundation

class FourierTransformer {
    func readFile(fileName: String) -> [Float] {
        let soundData = makeList(20)
        
        //Hayley, this is IO stuff that I couldn't figure out how to get working
        /*
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = URL(fileURLWithPath: fileName, relativeTo: directoryURL).appendingPathExtension("wav")
        
        let file = try! AVAudioFile(forReading: fileURL)
        guard let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false) else { return soundData }

        let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: 1024)
        try! file.read(into: buf!)

        soundData = Array(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))

        print("floatArray \(soundData)\n") */
        return soundData
    }
    
    func makeList(_ n: Int) -> [Float] {
        var randVals = [Float](repeating: 0, count: n)
        for i in 1...n {
            randVals[i] = Float.random(in: 0...255)
        }
        return randVals
    }
    
    
    func calculate(freqs: [Float]) -> ([Float], [Float]) {
        
        //this fourier transform stuff seems to be working from what I could tell though.
        let signalLength = vDSP_Length(freqs.count)
        //print(signalLength)
        
        let log2n = vDSP_Length(ceil(log2(Float(signalLength * 2))))
        
        let fourierTransform = vDSP.FFT(log2n: log2n, radix: .radix2, ofType: DSPSplitComplex.self)!
        
        var forwardInputReal = [Float](freqs) // Copy the signal here
        var forwardInputImag = [Float](repeating: 0, count: Int(signalLength))
        var forwardOutputReal = [Float](repeating: 0, count: Int(signalLength))
        var forwardOutputImag = [Float](repeating: 0, count: Int(signalLength))
        
        forwardInputReal.withUnsafeMutableBufferPointer { forwardInputRealPtr in
            forwardInputImag.withUnsafeMutableBufferPointer { forwardInputImagPtr in
                forwardOutputReal.withUnsafeMutableBufferPointer { forwardOutputRealPtr in
                    forwardOutputImag.withUnsafeMutableBufferPointer { forwardOutputImagPtr in
                        // Input
                        let forwardInput = DSPSplitComplex(realp: forwardInputRealPtr.baseAddress!, imagp: forwardInputImagPtr.baseAddress!)
                        // Output
                        var forwardOutput = DSPSplitComplex(realp: forwardOutputRealPtr.baseAddress!, imagp: forwardOutputImagPtr.baseAddress!)

                        fourierTransform.forward(input: forwardInput, output: &forwardOutput)
                    }
                }
            }
        }
        return (forwardOutputReal, forwardOutputImag)
    }
    
    func createSpectrogram() {
        static let sampleCount = 1024
        static let bufferCount = 768
        static let hopCount = 512
        
        guard
            let microphone = AVCaptureDevice.default(.builtInMicrophone,
                                                     for: .audio,
                                                     position: .unspecified),
            let microphoneInput = try? AVCaptureDeviceInput(device: microphone) else {
                fatalError("Can't create microphone.")
        }

        if captureSession.canAddInput(microphoneInput) {
            captureSession.addInput(microphoneInput)
        }
        
        captureSession.startRunning()
        
        var audioBufferList = AudioBufferList()
        var blockBuffer: CMBlockBuffer?

        CMSampleBufferGetAudioBufferListWithRetainedBlockBuffer(
            sampleBuffer,
            bufferListSizeNeededOut: nil,
            bufferListOut: &audioBufferList,
            bufferListSize: MemoryLayout.stride(ofValue: audioBufferList),
            blockBufferAllocator: nil,
            blockBufferMemoryAllocator: nil,
            flags: kCMSampleBufferFlag_AudioBufferList_Assure16ByteAlignment,
            blockBufferOut: &blockBuffer)

        guard let data = audioBufferList.mBuffers.mData else {
            return
        }
        
        let actualSampleCount = CMSampleBufferGetNumSamples(sampleBuffer)

        let ptr = data.bindMemory(to: Int16.self, capacity: actualSampleCount)
        let buf = UnsafeBufferPointer(start: ptr, count: actualSampleCount)

        rawAudioData.append(contentsOf: Array(buf))
        
        while rawAudioData.count >= AudioSpectrogram.sampleCount {
            let dataToProcess = Array(rawAudioData[0 ..< AudioSpectrogram.sampleCount])
            rawAudioData.removeFirst(AudioSpectrogram.hopCount)
            processData(values: dataToProcess)
        }

        createAudioSpectrogram()
        
        var timeDomainBuffer = [Float](repeating: 0, count: sampleCount)
        var frequencyDomainBuffer = [Float](repeating: 0, count: sampleCount)
        
        vDSP.convertElements(of: values, to: &timeDomainBuffer)
        
        let hanningWindow = vDSP.window(ofType: Float.self,
                                        usingSequence: .hanningDenormalized,
                                        count: sampleCount,
                                        isHalfWindow: false)
        
        vDSP.multiply(timeDomainBuffer,
                      hanningWindow,
                      result: &timeDomainBuffer)

        forwardDCT.transform(timeDomainBuffer,
                             result: &frequencyDomainBuffer)
        
        let maxFloats: [Float] = [255, maxFloat, maxFloat, maxFloat]
        let minFloats: [Float] = [255, 0, 0, 0]
        
        vDSP.absolute(frequencyDomainBuffer,
                      result: &frequencyDomainBuffer)

        vDSP.convert(amplitude: frequencyDomainBuffer,
                     toDecibels: &frequencyDomainBuffer,
                     zeroReference: Float(AudioSpectrogram.sampleCount))
        
        #if os(iOS)
        typealias Color = UIColor
        #else
        typealias Color = NSColor
        #endif

        
        static var redTable: [Pixel_8] = (0 ... 255).map {
            return brgValue(from: $0).red
        }

        static var greenTable: [Pixel_8] = (0 ... 255).map {
            return brgValue(from: $0).green
        }

        static var blueTable: [Pixel_8] = (0 ... 255).map {
            return brgValue(from: $0).blue
        }
        
        var rgbImageFormat: vImage_CGImageFormat = {
            guard let format = vImage_CGImageFormat(
                    bitsPerComponent: 8,
                    bitsPerPixel: 8 * 4,
                    colorSpace: CGColorSpaceCreateDeviceRGB(),
                    bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                    renderingIntent: .defaultIntent) else {
                fatalError("Can't create image format.")
            }
            
            return format
        }()
        
        lazy var rgbImageBuffer: vImage_Buffer = {
            guard let buffer = try? vImage_Buffer(width: AudioSpectrogram.sampleCount,
                                                  height: AudioSpectrogram.bufferCount,
                                                  bitsPerPixel: rgbImageFormat.bitsPerPixel) else {
                fatalError("Unable to initialize image buffer.")
            }
            return buffer
        }()

        /// RGB vImage buffer that contains a horizontal representation of the audio spectrogram.
        lazy var rotatedImageBuffer: vImage_Buffer = {
            guard let buffer = try? vImage_Buffer(width: AudioSpectrogram.bufferCount,
                                                  height: AudioSpectrogram.sampleCount,
                                                  bitsPerPixel: rgbImageFormat.bitsPerPixel)  else {
                fatalError("Unable to initialize rotated image buffer.")
            }
            return buffer
        }()
        
        let maxFloats: [Float] = [255, maxFloat, maxFloat, maxFloat]
        let minFloats: [Float] = [255, 0, 0, 0]

        frequencyDomainValues.withUnsafeMutableBufferPointer {
            var planarImageBuffer = vImage_Buffer(data: $0.baseAddress!,
                                                  height: vImagePixelCount(AudioSpectrogram.bufferCount),
                                                  width: vImagePixelCount(AudioSpectrogram.sampleCount),
                                                  rowBytes: AudioSpectrogram.sampleCount * MemoryLayout<Float>.stride)
            
            vImageConvert_PlanarFToARGB8888(&planarImageBuffer,
                                            &planarImageBuffer, &planarImageBuffer, &planarImageBuffer,
                                            &rgbImageBuffer,
                                            maxFloats, minFloats,
                                            vImage_Flags(kvImageNoFlags))
        }
        
        vImageTableLookUp_ARGB8888(&rgbImageBuffer, &rgbImageBuffer,
                                   nil,
                                   &AudioSpectrogram.redTable,
                                   &AudioSpectrogram.greenTable,
                                   &AudioSpectrogram.blueTable,
                                   vImage_Flags(kvImageNoFlags))
        
        vImageRotate90_ARGB8888(&rgbImageBuffer,
                                &rotatedImageBuffer,
                                UInt8(kRotate90DegreesCounterClockwise),
                                [UInt8()],
                                vImage_Flags(kvImageNoFlags))
    }
    
    static func brgValue(from value: Pixel_8) -> (red: Pixel_8,
                                                  green: Pixel_8,
                                                  blue: Pixel_8) {
        let normalizedValue = CGFloat(value) / 255
        
        // Define `hue` that's blue at `0.0` to red at `1.0`.
        let hue = 0.6666 - (0.6666 * normalizedValue)
        let brightness = sqrt(normalizedValue)

        let color = Color(hue: hue,
                          saturation: 1,
                          brightness: brightness,
                          alpha: 1)
        
        var red = CGFloat()
        var green = CGFloat()
        var blue = CGFloat()
        
        color.getRed(&red,
                     green: &green,
                     blue: &blue,
                     alpha: nil)
        
        return (Pixel_8(green * 255),
                Pixel_8(red * 255),
                Pixel_8(blue * 255))
    }
}
