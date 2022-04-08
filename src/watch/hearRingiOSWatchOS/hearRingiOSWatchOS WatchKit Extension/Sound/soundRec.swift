//
//  soundRecogntion.swift
//
//  Created by eddieredmann3 on 4/4/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

class soundRecognizer : SNAudioStreamAnalyzer {
    init() {
        startAudioEngine()
        self.soundAnalyzer = SNAudioStreamAnalyzer(format: self.inputFormat)
        
        let version1 = SNClassifierIdentifier.version1
        let self.soundRecRequest = try SNClassifySoundRequest(classifierIdentifier: version1)
        
        let self.resultsObserver = ResultsObserver()
        
        try self.soundAnalyzer.add(self.soundRecRequest, withObserver: self.resultsObserver)
    }
    
    deinit {
        reset()
    }
    
    func startAudioEngine() {
        // Create a new audio engine.
        self.audioEngine = AVAudioEngine()

        // Get the native audio format of the engine's input bus.
        self.inputBus = AVAudioNodeBus(0)
        self.inputFormat = audioEngine.inputNode.inputFormat(forBus: inputBus)
        
        do {
            // Start the stream of audio data.
            try self.audioEngine.start()
        } catch {
            print("Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }
    
    func installAudioTap() {
        self.audioEngine.inputNode.installTap(onBus: self.inputBus, bufferSize: 8192, format: self.inputFormat, block: analyzeAudio(buffer:at:))
    }
    
    func analyzeAudio(buffer: AVAudioBuffer, at time: AVAudioTime) {
        DispatchQueue.main.async {
            self.soundAnalyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
    }
}
