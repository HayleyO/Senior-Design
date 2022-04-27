//
//  VoicesView.swift
//  hearRingiOSWatchOS
//
//  Created by Jason on 4/20/22.
//

import SwiftUI


struct VoicesView: View {
    @State var voice_list: [VoiceSelection]
    @Binding var current_voice: Int
    
    var body: some View {
        List {
            ForEach (voice_list) { voice in
                HStack {
                    Text(voice.name)
                    Spacer()
                    if (voice.id == current_voice) {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    current_voice = voice.id
                }
            }
        }.onDisappear() {
            print(currentVoiceIndex)
            currentVoiceIndex = current_voice
            print(currentVoiceIndex)
        }
    }
}


