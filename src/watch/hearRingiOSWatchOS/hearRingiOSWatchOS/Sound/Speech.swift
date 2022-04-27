//
//  Speech.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 2/22/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

class SpeechRecognizer: ObservableObject {
    @Published var transcript: String = ""
    
    let speechRecognizer = SFSpeechRecognizer()!
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var audioEngine = AVAudioEngine()
    var speechTimer = Timer()
    
    func startRecording() throws {
      // Cancel the previous recognition task.
      recognitionTask?.cancel()
      recognitionTask = nil
      
      // Audio session, to get information from the microphone.
      let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .spokenAudio, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode
      
      // The AudioBuffer
      recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
      recognitionRequest!.shouldReportPartialResults = true
      
      // Force speech recognition to be on-device
      /*if #available(iOS 13, *) {
        recognitionRequest!.requiresOnDeviceRecognition = true
      }*/
      
      // Actually create the recognition task. We need to keep a pointer to it so we can stop it.
      recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!) { result, error in
        var isFinal = false
        
        if let result = result {
          isFinal = result.isFinal
            self.transcript = result.bestTranscription.formattedString
        }
        
        if error != nil || isFinal {
          // Stop recognizing speech if there is a problem.
            self.audioEngine.stop()
            inputNode.removeTap(onBus: 0)
          
            self.recognitionRequest = nil
            self.recognitionTask = nil
            if isFinal && error == nil{
                self.refresh()
            }
        }
      }
        // Configure the microphone.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        // The buffer size tells us how much data should the microphone record before dumping it into the recognition request.
        inputNode.reset()
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
          self.recognitionRequest?.append(buffer)
            
        }
        audioEngine.prepare()
        try audioEngine.start()
    }
    
    deinit {
        reset()
    }
    
    func refresh(){
        reset()
        transcript = "" 
        try! startRecording()
    }

    func reset() {
        self.recognitionTask?.cancel()
        self.audioEngine.stop()
        //self.audioEngine = AVAudioEngine()
        self.recognitionRequest = nil
        self.recognitionTask = nil
    }
    
    @objc func timerCallback() {
        refresh()
    }
}

