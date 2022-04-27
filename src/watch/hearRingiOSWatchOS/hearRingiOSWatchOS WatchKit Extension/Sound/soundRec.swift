//
//  soundRecogntion.swift
//
//  Created by eddieredmann3 on 4/4/22.
//

import AVFoundation
import Foundation
import SoundAnalysis
import SwiftUI
import AVFAudio

class soundRecognizer : NSObject {
    let audioEngine: AVAudioEngine = AVAudioEngine()
    let inputBus: AVAudioNodeBus = AVAudioNodeBus(0)
    var inputFormat: AVAudioFormat!
    var streamAnalyzer: SNAudioStreamAnalyzer!
    let sound = SoundResultsObserver()
    var sound_val:SNClassification!
    var out:String!
    
    override init() {
        super.init()
        
        inputFormat = audioEngine.inputNode.inputFormat(forBus: inputBus)
        
        do {
            try audioEngine.start()

            audioEngine.inputNode.installTap(onBus: inputBus, bufferSize: 8192, format: inputFormat, block: analyzeAudio(buffer:at:))

            streamAnalyzer = SNAudioStreamAnalyzer(format: inputFormat)

            let request = try SNClassifySoundRequest(classifierIdentifier: SNClassifierIdentifier.version1)

            try streamAnalyzer.add(request, withObserver: sound)

        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    func analyzeAudio(buffer: AVAudioBuffer, at time: AVAudioTime) {
        DispatchQueue.main.async {
            self.streamAnalyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
        sound_val = sound.globalClassification
        if sound_val != nil {
            out = sound_val.identifier
        }
    }
}
