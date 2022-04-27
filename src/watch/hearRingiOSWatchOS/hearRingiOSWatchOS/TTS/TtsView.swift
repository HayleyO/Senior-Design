//
//  TtsView.swift
//  hearRingiOSWatchOS
//
//  Created by Jason on 3/21/22.
//

import SwiftUI
import AVFoundation

let ViewModel = TTSViewModel()

//Voice Creation Variables
let TTSVoices = AVSpeechSynthesisVoice.speechVoices()
var VoiceGroup: [AVSpeechSynthesisVoice] = []
var currentVoiceIndex: Int = 0

struct VoiceSelection: Identifiable {
    var id: Int
    let name: String
    let voice: AVSpeechSynthesisVoice
}

var currentText = "You forgot to input a message!"

struct TtsView: View {
    @State var Voices: [VoiceSelection] = []
    @State var current_voice: Int = 0
    @State var voiceText: String = "No Voice Selected"
    
    @State var text = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                List {
                    NavigationLink {
                        VoicesView(voice_list: Voices, current_voice: self.$current_voice)
                    } label : {
                        HStack {
                            Text("Voices")
                            Spacer()
                            Text(voiceText)
                                .font(.subheadline)
                                .onChange(of: current_voice) { _ in
                                    voiceText = Voices[current_voice].name
                                    currentVoiceIndex = current_voice
                                }
                        }
                    }
                }
                VStack {
                TextField("Type your message here...", text: $text)
                    .onChange(of: text) {_ in currentText = text}.padding()
                    .textFieldStyle(.roundedBorder)
                Button("Speak", action: doSpeech)
                    .buttonStyle(.borderedProminent)
                    
                }
            }
            .navigationTitle("Text to Speech")
        }.onAppear() {
            if(Voices.isEmpty) {
                var appendedValue = 0
                
                for voiceIndex in 0...TTSVoices.count-1 {
                    let tempCondition = TTSVoices[voiceIndex].language.split(separator:"-")
                    
                    if(tempCondition[0] == "en") {
                        let tempVoiceName: String = TTSVoices[voiceIndex].name + " (" + TTSVoices[voiceIndex].language + ")"
                        let tempVoiceSelection = VoiceSelection(id: appendedValue, name: tempVoiceName, voice: TTSVoices[voiceIndex])
                        
                        Voices.append(tempVoiceSelection)
                        VoiceGroup.append(TTSVoices[voiceIndex])
                        appendedValue += 1
                    } else {}
                }
            }
            current_voice = currentVoiceIndex
        }
    }
}

private func doSpeech() {
    ViewModel.speechUtterance = AVSpeechUtterance(string: currentText)
    
    let voice = VoiceGroup[currentVoiceIndex]
    ViewModel.speechUtterance.voice = voice
    
    ViewModel.speechSynthesis.speak(ViewModel.speechUtterance)
    
}

struct TtsView_Previews: PreviewProvider {
    static var previews: some View {
        TtsView()
    }
}
