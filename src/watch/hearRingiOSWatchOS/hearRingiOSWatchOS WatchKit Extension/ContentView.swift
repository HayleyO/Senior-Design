//
//  ContentView.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI
import Foundation
import AVFAudio
import SoundAnalysis

struct ContentView: View {
    @StateObject var sharedData = Connectivity.shared
    @ObservedObject var dataModel = Chunking()
    
    private let soundRecAudioEngine: AVAudioEngine = AVAudioEngine() // Mark 1
    private let soundRecInputBus: AVAudioNodeBus = AVAudioNodeBus(0) // Mark 2
    private var soundRecInputFormat: AVAudioFormat!
    private var soundRecStreamAnalyzer: SNAudioStreamAnalyzer!
    private let soundRecResultsObserver = SoundResultsObserver() // Mark 3
    private let soundRecAnalysisQueue = DispatchQueue(label: "com.example.AnalysisQueue")
    
    var body: some View {
        VStack {
            ProgressView("Recording...", value: dataModel.decibel, total: 160).progressViewStyle(LinearProgressViewStyle(tint: dataModel.tintColor))
                
                .onAppear() {
                    DispatchQueue.main.async {
                        let recordModel = Record(chunker: dataModel)
                        recordModel.setup()
                        recordModel.start()
                    }
                }
            
            
            Text(sharedData.AlarmChanged.alarmName)
            Text(String(sharedData.AlarmChanged.alarmEnabled))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
