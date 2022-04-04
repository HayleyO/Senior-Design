//
//  fourier_transform.swift
//  hearring_12.4
//
//  Created by coes on 3/28/22.
//

import Foundation
import Accelerate
import AVFoundation

class FourierTransformer {
    func readFile(fileName: String) -> [Float] {
        var soundData = [Float]()

        //Hayley, this is IO stuff that I couldn't figure out how to get working
        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        //print(url.absoluteString)
        let file = try! AVAudioFile(forReading: url)
        let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)

        let buf = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: 1024)
        try! file.read(into: buf!)

        // this makes a copy, you might not want that
        soundData = Array(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))
        
        return soundData
    }
    
    func makeList(_ n: Int) -> [Float] {
        var randVals = [Float](repeating: 0, count: n)
        for i in 1..<n {
            randVals[i] = Float.random(in: 0...255)
        }
        return randVals
    }
    
    
    func calculate(freqs: [Float]) -> ([Float], [Float]) {
        let signalLength = vDSP_Length(freqs.count)
        //print(freqs)
        //print(signalLength)
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
    print(forwardOutputReal)
    print(forwardOutputImag)
    return (forwardOutputReal, forwardOutputImag)
    }
}
