//
//  ContentView.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    var body: some View {
        NavigationView {
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text(speechRecognizer.transcript)
                        .padding()
                        
                    Spacer()
                }
                
            }
            .navigationTitle("Listening...")
        }
        .onAppear{
            let floatArray = read_in_wav()
            let result = fourier_calculate(freqs: floatArray)
            speechRecognizer.reset()
            speechRecognizer.transcribe()
        }
        .onDisappear{
            speechRecognizer.stopTranscribing()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
