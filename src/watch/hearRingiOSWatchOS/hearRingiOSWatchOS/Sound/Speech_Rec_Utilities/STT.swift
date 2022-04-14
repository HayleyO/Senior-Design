//
//  STT.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 4/13/22.
//

import Foundation
import AVFoundation


import AVFoundation

class STTRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate
{
    @Published var transcript: String = ""
    
    func getDocumentsDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getFileUrl() -> URL
    {
        let filename = "myRecording.wav"
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    /*
    var engine = AVAudioEngine()
    var mixerNode = AVAudioMixerNode()
    var file: AVAudioFile?
    var player = AVAudioPlayerNode() // Optional

    
    func startRecording() {
        // Set volume to 0 to avoid audio feedback while recording.
        //mixerNode.volume = 0

        engine.attach(mixerNode)

        let inputNode = engine.inputNode
        let inputFormat = inputNode.outputFormat(forBus: 0)
        engine.connect(inputNode, to: mixerNode, format: inputFormat)
        
        //engine.attach(player)
        //engine.connect(player, to: engine.mainMixerNode, format: engine.mainMixerNode.outputFormat(forBus: 0))
        
        let mainMixerNode = engine.mainMixerNode
        let mixerFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: false)
        engine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)
            
        // Prepare the engine in advance, in order for the system to allocate the necessary resources.
        engine.prepare()
        
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)
              
        // AVAudioFile uses the Core Audio Format (CAF) to write to disk.
        // So we're using the caf file extension.
        let file = try! AVAudioFile(forWriting: getFileUrl(), settings: format.settings)
        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
        (buffer, time) in
            try? file.write(from: buffer)
        })

        try! engine.start()
        interrupts()
    }
    
    func stopRecording() {
        engine.inputNode.removeTap(onBus: 0)
        engine.stop()
    }
     */
    
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    func startRecording(){

        let audioSession = AVAudioSession.sharedInstance()

        try! audioSession.setCategory(.playAndRecord)
        try! audioSession.setActive(true)
        audioSession.requestRecordPermission({(allowed: Bool) -> Void in print("Accepted")} )


        let settings = [
                AVFormatIDKey:Int(kAudioFormatLinearPCM),
                AVSampleRateKey:48000,
                AVNumberOfChannelsKey:1,
                AVLinearPCMBitDepthKey:8,
                AVLinearPCMIsFloatKey:false,
                AVLinearPCMIsBigEndianKey:false,
                AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue
        ] as [String : Any]

        audioRecorder = try! AVAudioRecorder(url: getFileUrl(), settings: settings)
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        
        audioPlayer = try? AVAudioPlayer(contentsOf: getFileUrl())
        audioPlayer?.delegate = self
        audioPlayer?.prepareToPlay()
        
        audioRecorder.record()
        interrupts()
    }
    
    @IBAction func stopRecording()
    {
        audioRecorder.stop()
    }
    
    @IBAction func playRecording()
    {
        audioPlayer = try? AVAudioPlayer(contentsOf: getFileUrl())
        audioPlayer.play()
    }
    
    var sttTimer = Timer()
    
    func interrupts()
    {
        self.sttTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false){_ in
            self.timerCallback()
        }
    }
    
    @objc func timerCallback() {
        stopRecording()
        playRecording()
        let audio = read_in_audio(url: getFileUrl())
        DispatchQueue.main.async { [self] in
            let string = predict(input: preprocess(input: audio))
            print(string)
            transcript = transcript + string
        }
        //startRecording()
        self.interrupts()
    }
    
}
