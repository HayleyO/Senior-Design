//
//  soundRecogntion.swift
//
//  Created by eddieredmann3 on 4/4/22.
//

import AVFoundation
import Foundation
import SoundAnalysis
import SwiftUI
import Speech
import AVFAudio

class soundRecognizer : NSObject {
    private let audioEngine: AVAudioEngine = AVAudioEngine() // Mark 1
    private let inputBus: AVAudioNodeBus = AVAudioNodeBus(0) // Mark 2
    private var inputFormat: AVAudioFormat!
    private var streamAnalyzer: SNAudioStreamAnalyzer!
    private let sound = SoundResultsObserver()
    
    override init() {
        super.init()
        
        inputFormat = audioEngine.inputNode.inputFormat(forBus: inputBus)
        
        do {
            try audioEngine.start()

            audioEngine.inputNode.installTap(onBus: inputBus, bufferSize: 8192, format: inputFormat, block: analyzeAudio(buffer:at:))

            streamAnalyzer = SNAudioStreamAnalyzer(format: inputFormat)

            let request = try SNClassifySoundRequest(classifierIdentifier: SNClassifierIdentifier.version1) // Mark 5

            try streamAnalyzer.add(request, withObserver: sound) // Mark 6


        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    func analyzeAudio(buffer: AVAudioBuffer, at time: AVAudioTime) {
        DispatchQueue.main.async {
            self.streamAnalyzer.analyze(buffer,
                                        atAudioFramePosition: time.sampleTime)
        }
    }
}
