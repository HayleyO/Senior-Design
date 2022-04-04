//
//  TtsView.swift
//  hearRingiOSWatchOS
//
//  Created by Jason on 3/21/22.
//

import SwiftUI
import AVFoundation

let ViewModel = TTSViewModel()

//Voice Selection Variables
let TTSVoices = AVSpeechSynthesisVoice.speechVoices()
var currentVoiceIndex: Int = 0

struct VoiceSelection: Identifiable {
    var id: Int
    let name: String
    let voice: AVSpeechSynthesisVoice
}

var currentText = "You forgot to input a message!"

struct TtsView: View {
    @State var Voices: [VoiceSelection] = []
    @State var voiceSelected = 0
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Voice List")
                Picker("Voice", selection: $voiceSelected) {
                    ForEach(Voices) { voice in
                        Text(voice.name).tag(voice.id)
                    }
                }.pickerStyle(WheelPickerStyle())
                .onChange(of: voiceSelected) {_ in
                    currentVoiceIndex = voiceSelected
                }.padding()
                TextField("Type your message here...", text: $text)
                    .onChange(of: text) {_ in currentText = text}.padding()
                    .textFieldStyle(.roundedBorder)
                Button("Speak", action: doSpeech)
                    .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Text to Speech")
        }.onAppear() {
            for voiceIndex in 0...TTSVoices.count-1 {
                let tempVoiceSelection = VoiceSelection(id: voiceIndex, name: TTSVoices[voiceIndex].name, voice: TTSVoices[voiceIndex])
                Voices.append(tempVoiceSelection)
            }
        }
    }
}

private func doSpeech() {
    ViewModel.speechUtterance = AVSpeechUtterance(string: currentText)
    
    let voice = TTSVoices[currentVoiceIndex]
    ViewModel.speechUtterance.voice = voice
    
    ViewModel.speechSynthesis.speak(ViewModel.speechUtterance)
    
}

struct TtsView_Previews: PreviewProvider {
    static var previews: some View {
        TtsView()
    }
}
