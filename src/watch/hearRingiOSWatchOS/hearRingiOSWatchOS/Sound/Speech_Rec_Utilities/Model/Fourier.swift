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

func fourier_calculate(freqs: [Float]) -> ([Float], [Float]){
    
    let signal = freqs
    
    let frame_length = 256 // n_frame
    let frame_step = 160 // n_hop
    let fft_length = 384 // should end up with array of 1+fft_length/2
    
    //define the transform
    //
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
        //perform transform
        //result = (forwardDCT?.transform(temp_array))
        //store result
        x[k] = temp_array
    }
    
    print(x)
    //Should be the shape 256, 193 when it exits
    return ([0.0],[0.0])
}
