//
//  Fourier.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/4/22.
//

import Foundation
import AVFoundation
import Accelerate
    
func read_in_wav(fileName:String = "LJ001-0078.wav") -> [Float]{
    
    let path = Bundle.main.path(forResource: fileName, ofType: nil)!
    let url = URL(fileURLWithPath: path)
    let file = try! AVAudioFile(forReading: url)
    let audioFrameCount = UInt32(file.length)
    let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)!

    let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: audioFrameCount)
    try! file.read(into: buf!)

    // this makes a copy, you might not want that
    let floatArray = Array<Float>(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))
    return floatArray
}

func read_in_audio(url:URL) -> [Float]{
    
    //let path = Bundle.main.path(forResource: fileName, ofType: nil)!
    //let url = URL(fileURLWithPath: path)
    let file = try! AVAudioFile(forReading: url)
    let audioFrameCount = UInt32(file.length)
    let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)!

    let buf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: audioFrameCount)
    try! file.read(into: buf!)

    // this makes a copy, you might not want that
    let floatArray = Array<Float>(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))
    //let returnArray = Array(floatArray[(movement*hop)..<((movement+1)*hop)])
    return floatArray
}

func preprocess(input:[Float])-> [[Double]]
{
    let output_1 = fourier_calculate(freqs: input)
    return normalize(input: (output_1))
}

func fourier_calculate(freqs: [Float]) -> [[Double]]{
    
    let signal = freqs
    
    let frame_length = 256 // n_frame
    let frame_step = 160 // n_hop
    let fft_length = 384 // should end up with array of 1+fft_length/2
    
    //define the hanning window
    let window = vDSP.window(ofType: Float.self, usingSequence: .hanningDenormalized, count: frame_length, isHalfWindow: false)
    
    //frame signal
    let frame_count = 1 + (signal.count - frame_length) / frame_step
    var x = [[Double]](repeating: [Double](repeating: 0.0, count: frame_length), count: frame_count) //1+fft_length/2), count: frame_count)

    //perform calculations
    for k in 0...(frame_count-1){
        //get frame
        var temp_array = Array(signal[k*frame_step...k*frame_step+frame_length-1])
        //get frame * hanning window
        temp_array = vDSP.multiply(temp_array, window)
        //pad the array
        let padded_array = pad_signal(signal: &temp_array, fft_length: fft_length)
        //perform transform
        let transformed_data = dft(freqs:padded_array, fft_length: fft_length)
        //store result
        x[k] = transformed_data
    }
    return x
}

func dft(freqs: [Double], fft_length: Int) -> [Double]
{
    let N = freqs.count
    //let x_even = stride(from: 0, to: N, by: 2)
    //let x_odd = stride(from: 1, to: N, by: 2)
    
    var xReal: [Double] = Array(repeating: 0, count: N)
    var xImaginary: [Double] = Array(repeating: 0, count: N)
    
    let f = 2.0 * Double.pi / Double(N)
    for k in 0 ..< N {

        let kf = Double(k) * f
        let (cosa, sina) = (cos(kf), sin(kf))
        var (cosq, sinq) = (1.0, 0.0)

        for n in 0 ..< N {
            xReal[k] += freqs[n] * cosq
            xImaginary[k] -= freqs[n] * sinq
            (cosq, sinq) = (cosq * cosa - sinq * sina, sinq * cosa + cosq * sina)
        }
    }
    
    let new_length = 1+fft_length/2
    return Array(xReal[0...new_length-1])
}

func fft()
{
    
}

func pad_signal(signal: inout [Float], fft_length: Int) -> [Double]
{
    let new_dimension_padding = fft_length - signal.count
    for _ in 0...new_dimension_padding-1
    {
        signal.append(0.0)
    }
    let newSignal: [Double] = signal.map { Double($0)}
    return newSignal
}

func sqrt(_ x: [Double]) -> [Double] {
    var results = [Double](repeating: 0.0, count: x.count)
    vvsqrt(&results, x, [Int32(x.count)])

    return results
}

func normalize(input:[[Double]]) -> [[Double]]
{
    let inputAbs = input.map { $0.map { abs($0) } }
    let inputPow = inputAbs.map { $0.map { pow($0, 0.5)}}
    //let inputReAbs = inputPow.map { $0.map { abs($0) } }
    
    //print(inputReAbs)
    //normalization
    var result = [[Double]](repeating: [Double](repeating: 0.0, count: input[0].count), count: input.count)
    for x in 0..<inputPow.count
    {
        //print(inputPow[x])
        let mean = get_mean(input: inputPow[x])
        let std_dev = get_std_dev(input: inputPow[x])
        for y in 0..<inputPow[x].count
        {
            //result = (input - means)/ (std_devs + 1e-10)
            result[x][y] = (inputPow[x][y] - mean)/(std_dev + 1e-10)
        }
    }
    return result
}

func get_mean(input:[Double]) -> Double
{
    let sumArray = input.reduce(0, +) //Add up all values starting at 0
    return sumArray / Double(input.count)
}

func get_std_dev(input:[Double]) -> Double
{
    let mean = get_mean(input: input)
    let v = input.reduce(0, {$0 + ($1-mean) * ($1-mean) })
    return sqrt(v / Double(input.count - 1))
}
