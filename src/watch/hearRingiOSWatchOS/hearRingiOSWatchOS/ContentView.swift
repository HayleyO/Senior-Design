//
//  ContentView.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @StateObject var speechSTT = STTRecorder()
    var body: some View {
        NavigationView {
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(speechSTT.transcript)
                        .padding()
                        
                    Spacer()
                }
                
            }
            .navigationTitle("Listening...")
        }
        .onAppear{
            //read_in_wav()
            //var string = predict(input: preprocess(input: read_in_wav(fileName: "LJ001-0136.wav")))
            speechSTT.startRecording()
            //speechRecognizer.reset()
            //speechRecognizer.transcribe()
        }
        .onDisappear{
            speechRecognizer.stopTranscribing()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
                try audioSession.setActive(false, options: .notifyOthersOnDeactivation)
            } catch {
                // handle errors
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
