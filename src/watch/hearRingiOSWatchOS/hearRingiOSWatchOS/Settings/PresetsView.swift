//
//  PresetsView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 4/5/22.
//

import SwiftUI

struct PresetsView: View {
    @Binding var originalSelected: String
    
    @State var selectedPreset: String = "No Preset"
    
    //user-immutable default pre-loaded presets
    struct DefaultPreset: Identifiable {
        var id = UUID()
        var name: String
        var lowThreshold: Double
        var highThreshold: Double
    }
    let defaultPresets =
    [
        DefaultPreset(name: "Indoors", lowThreshold: 30.0, highThreshold: 70.0),
        DefaultPreset(name: "Outdoors", lowThreshold: 70.0, highThreshold: 100.0),
        DefaultPreset(name: "Resturaunt", lowThreshold: 60.0, highThreshold: 105.0),
        DefaultPreset(name: "Sleep", lowThreshold: 20.0, highThreshold: 50.0)
    ]
    
    @FetchRequest(sortDescriptors: []) var userPresets: FetchedResults<PresetEntity>
    
    var body: some View {
        List {
            Section(header: Text("None")) {
                HStack {
                    Text("No Preset")
                    Spacer()
                    if ("No Preset" == selectedPreset) {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedPreset = "No Preset"
                }
            }
            Section(header: Text("Defaults")) {
                ForEach(defaultPresets) { preset in
                    HStack {
                        Text(preset.name)
                        Spacer()
                        if (preset.name == selectedPreset) {
                            Image(systemName: "checkmark")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedPreset = preset.name
                        //modify SettingsEntity in core data here, set equal to preset.lowThreshold and preset.highThreshold
                        //don't forget to try? moc.save() and send to Connectivity
                    }
                }
            }
            // displays user-defined presets from core data
            Section(header: Text("Custom")) {
                ForEach(userPresets, id: \.self) { preset in
                     HStack {
                         Text(preset.name ?? "")
                         Spacer()
                         if (preset.name == selectedPreset) {
                             Image(systemName: "checkmark")
                         }
                     }
                     .contentShape(Rectangle())
                     .onTapGesture {
                         selectedPreset = preset.name ?? ""
                         //same logic as above
                     }
                }
            }
            
        }
        .toolbar {
            NavigationLink(destination: PresetCreate()) {
                Image(systemName: "plus")
            }
            .accessibilityIdentifier("Create New Alarm")
        }
        .onAppear {
            selectedPreset = originalSelected
        }
        .onDisappear {
            originalSelected = selectedPreset
        }
    }
}

//no previews available for this page due to how it takes a binding from SettingsView
