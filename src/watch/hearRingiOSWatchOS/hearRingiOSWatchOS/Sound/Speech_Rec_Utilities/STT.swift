//
//  STT.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/13/22.
//

import Foundation
import AVFoundation


import AVFoundation

class Recorder: ObservableObject
{
  enum RecordingState {
    case recording, paused, stopped
  }
  
  private var engine: AVAudioEngine!
  private var mixerNode: AVAudioMixerNode!
  private var state: RecordingState = .stopped
  
  init() {
    setupSession()
    setupEngine()
  }
    
    fileprivate func setupSession() {
      let session = AVAudioSession.sharedInstance()
      try? session.setCategory(.record)
      try? session.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    fileprivate func setupEngine() {
      engine = AVAudioEngine()
      mixerNode = AVAudioMixerNode()

      // Set volume to 0 to avoid audio feedback while recording.
      mixerNode.volume = 0

      engine.attach(mixerNode)

      makeConnections()
      
      // Prepare the engine in advance, in order for the system to allocate the necessary resources.
      engine.prepare()
    }

    fileprivate func makeConnections() {
      let inputNode = engine.inputNode
      let inputFormat = inputNode.outputFormat(forBus: 0)
      engine.connect(inputNode, to: mixerNode, format: inputFormat)

      let mainMixerNode = engine.mainMixerNode
      let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
      engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)
    }
    
    func getURL() -> URL
    {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentURL.appendingPathComponent("recording.caf")
    }
    
    func startRecording() throws {
      let tapNode: AVAudioNode = mixerNode
      let format = tapNode.outputFormat(forBus: 0)
      
      // AVAudioFile uses the Core Audio Format (CAF) to write to disk.
      // So we're using the caf file extension.
      let file = try AVAudioFile(forWriting: getURL(), settings: format.settings)

      tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
        (buffer, time) in
        try? file.write(from: buffer)
      })

      try engine.start()
      state = .recording
      interrupts()
    }
    
    func resumeRecording() throws {
      try engine.start()
      state = .recording
    }

    func pauseRecording() {
      engine.pause()
      state = .paused
    }

    func stopRecording() {
      // Remove existing taps on nodes
      mixerNode.removeTap(onBus: 0)
      
      engine.stop()
      state = .stopped
    }
    

    fileprivate var isInterrupted = false

    // Call this function at init
    fileprivate func registerForNotifications() {
      NotificationCenter.default.addObserver(
        forName: AVAudioSession.interruptionNotification,
        object: nil,
        queue: nil
      )
      { [weak self] (notification) in
        guard let weakself = self else {
          return
        }

        let userInfo = notification.userInfo
        let interruptionTypeValue: UInt = userInfo?[AVAudioSessionInterruptionTypeKey] as? UInt ?? 0
        let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeValue)!

        switch interruptionType {
        case .began:
          weakself.isInterrupted = true

          if weakself.state == .recording {
            weakself.pauseRecording()
          }
        case .ended:
          weakself.isInterrupted = false

          // Activate session again
          try? AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

          //weakself.handleConfigurationChange()

          if weakself.state == .paused {
            try? weakself.resumeRecording()
          }
        @unknown default:
          break
        }
      }
    }
    
    var sttTimer = Timer()
    
    func interrupts()
    {
        self.sttTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false){_ in
            self.timerCallback()
        }
    }
    
    @objc func timerCallback() {
        //stopRecording()
        var string = predict(input: preprocess(input: read_in_audio(url: getURL())))
        print(string)
        //startRecording()
        self.interrupts()
    }
    
}
