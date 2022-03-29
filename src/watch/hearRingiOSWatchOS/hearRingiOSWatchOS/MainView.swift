//
//  MainView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Listen", systemImage: "ear.and.waveform")
                }
            TtsView()
                .tabItem {
                    Label("Speak", systemImage: "message.and.waveform")
                }
            AlarmView()
                .tabItem {
                    Label("Alarm", systemImage: "alarm")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
