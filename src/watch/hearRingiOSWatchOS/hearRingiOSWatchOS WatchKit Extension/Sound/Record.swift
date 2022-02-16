//
//  Record.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import Foundation
import AVFoundation

class Record : NSObject, AVAudioRecorderDelegate{
    
    var soundURL: String!
    var audioRecorder:AVAudioRecorder?
    var levelTimer = Timer()
    var chunking: Chunking
    var vibration: Vibration?
    
    init(chunker: Chunking)
    {
        chunking = chunker
    }
    
    func setup(){
        let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        let audioFileName = UUID().uuidString + ".m4a"
        let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
        soundURL = audioFileName
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playAndRecord)), mode: .default)
        } catch _ {
            
        }
        
        let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1]
        
        audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
        audioRecorder?.delegate = self
        audioRecorder?.prepareToRecord()
    }
    
    func start()
    {
        if let recorder = audioRecorder{
            if !recorder.isRecording{
                let audioSession = AVAudioSession.sharedInstance()
                do {
                    try audioSession.setActive(true)
                } catch _ {
                    
                }
            }
            recorder.isMeteringEnabled = true
            recorder.record()
            self.levelTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){_ in
                self.timerCallback()
            }
        }
    }
    
    func stop()
    {
        if let recorder = audioRecorder{
            if recorder.isRecording{
                audioRecorder?.stop()
                let audioSession = AVAudioSession.sharedInstance()
                do{
                    try audioSession.setActive(false)
                } catch _{
                    
                }
            }
        }
    }
    
    @objc func timerCallback() {
        let recorder = audioRecorder
        recorder?.updateMeters()
        
        let SPL = 20 * log10(5 * powf(10, ((recorder?.averagePower(forChannel: 0))!/20)) * 160) + 25
        print(SPL)
        chunking.decibel = SPL
        chunking.tintColor = chunking.getColorFromDecibel()
        
        vibration?.vibrate(volume: SPL)
        self.stop()
        self.start()
    }
    
    fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
        return input.rawValue
    }
}
