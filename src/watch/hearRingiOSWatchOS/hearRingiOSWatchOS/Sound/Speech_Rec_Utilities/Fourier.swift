//
//  Fourier.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/4/22.
//

import Foundation
import AVFoundation
import Accelerate
    
func read_in_wav() -> [Float]{
    
    let path = Bundle.main.path(forResource: "LJ001-0078.wav", ofType: nil)!
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

func preprocess(input:[Float])-> [[Float]]
{
    let output_1 = fourier_calculate(freqs: input)
    return normalize(input: output_1)
}

func fourier_calculate(freqs: [Float]) -> [[Float]]{
    
    let signal = freqs
    
    let frame_length = 256 // n_frame
    let frame_step = 160 // n_hop
    let fft_length = 384 // should end up with array of 1+fft_length/2
    
    //define the hanning window
    let window = vDSP.window(ofType: Float.self, usingSequence: .hanningDenormalized, count: frame_length, isHalfWindow: false)
    
    //frame signal
    let frame_count = 1 + (signal.count - frame_length) / frame_step
    var x = [[Float]](repeating: [Float](repeating: 0.0, count: frame_length), count: frame_count) //1+fft_length/2), count: frame_count)

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
    //Should be the shape 256, 193 when it exits
    return x
}

func dft(freqs: [Float], fft_length: Int) -> [Float]
{
    let N = freqs.count
    //let x_even = stride(from: 0, to: N, by: 2)
    //let x_odd = stride(from: 1, to: N, by: 2)
    
    var xReal: [Float] = Array(repeating: 0, count: N)
    var xImaginary: [Float] = Array(repeating: 0, count: N)
    
    for k in 0..<N
    {
        for n in 0..<N
        {
            //X_j*e^(-2j*pi*n*k/N)
            let q = -2.0 * Double(n) * Double.pi * Double(k)/Double(N)
            xReal[k] += freqs[n]*Float(cos(q))
            xImaginary[k] -= freqs[n]*Float(sin(q))
        }
    }
    
    let new_length = 1+fft_length/2
    return Array(xReal[0...new_length-1])
}

func pad_signal(signal: inout [Float], fft_length: Int) -> [Float]
{
    let new_dimension_padding = fft_length - signal.count
    for _ in 0...new_dimension_padding-1
    {
        signal.append(0.0)
    }
    return signal
}

func normalize(input:[[Float]]) -> [[Float]]
{
    let inputAbs = input.map { $0.map { abs($0) } }
    let inputPow = inputAbs.map { $0.map { pow($0, 0.5)}}
    let inputReAbs = inputPow.map { $0.map { abs($0) } }
    
    print(inputReAbs)
    //normalization
    var result = [[Float]](repeating: [Float](repeating: 0.0, count: input[0].count), count: input.count)
    for x in 0..<inputReAbs.count
    {
        print(inputReAbs[x])
        let mean = get_mean(input: inputReAbs[x])
        let std_dev = get_std_dev(input: inputReAbs[x])
        for y in 0..<inputReAbs[x].count
        {
            //result = (input - means)/ (std_devs + 1e-10)
            result[x][y] = (inputReAbs[x][y] - mean)/(std_dev + 1e-10)
        }
    }
    return result
}

func get_mean(input:[Float]) -> Float
{
    let sumArray = input.reduce(0, +) //Add up all values starting at 0
    return sumArray / Float(input.count)
}

func get_std_dev(input:[Float]) -> Float
{
    let mean = get_mean(input: input)
    let v = input.reduce(0, {$0 + ($1-mean) * ($1-mean) })
    return sqrt(v / Float(input.count - 1))
}
