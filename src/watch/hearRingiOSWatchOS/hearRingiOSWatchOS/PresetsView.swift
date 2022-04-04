//
//  PresetsView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 4/4/22.
//

import SwiftUI

struct PresetsView: View {
    enum Preset: String, CaseIterable, Identifiable {
        case indoors, outdoors, resturaunt, sleep
        var id: Self { self }
    }

    @State private var selectedPreset: Preset = .indoors
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Preset", selection: $selectedPreset) {
                    Text("Indoors").tag(Preset.indoors)
                    Text("Outdoors").tag(Preset.outdoors)
                    Text("Resturaunt").tag(Preset.resturaunt)
                    Text("Sleep").tag(Preset.sleep)
                }
                .pickerStyle(.menu)
                Spacer()
                NavigationLink(destination: SettingsView()) {
                    Text("Advanced Settings")
                        .padding()
                }
            }
            .navigationTitle("Presets")
        }
    }
}

struct PresetsView_Previews: PreviewProvider {
    static var previews: some View {
        PresetsView()
    }
}
