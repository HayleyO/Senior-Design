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
    @State var editingEnabled: Bool = false
    
    @State var controller = DataController.Controller
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    @State var exit_presets: Bool = true
    
    //user-immutable default pre-loaded presets
    struct DefaultPreset: Identifiable {
        var id = UUID()
        var name: String
        var weakValue: Double
        var strongValue: Double
    }
    
    let defaultPresets =
    [
        DefaultPreset(name: "Indoors", weakValue: 30.0, strongValue: 70.0),
        DefaultPreset(name: "Outdoors", weakValue: 70.0, strongValue: 100.0),
        DefaultPreset(name: "Resturaunt", weakValue: 60.0, strongValue: 105.0),
        DefaultPreset(name: "Sleep", weakValue: 20.0, strongValue: 50.0)
    ]
    
    @FetchRequest(sortDescriptors: []) var userPresets: FetchedResults<PresetEntity>
    @Environment(\.managedObjectContext) var moc
    
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
                        
                        settings.weakValue = preset.weakValue
                        settings.strongValue = preset.strongValue
                    }
                }
            }
            // displays user-defined presets from core data
            Section (header:
                HStack {
                    Text("Custom")
                    Spacer()
                    Button(action: {
                        editingEnabled.toggle()
                        if(editingEnabled == true) {
                            selectedPreset = "No Preset"
                        }
                    },
                    label: {
                        Text("Edit")
                    })
                },
                content: {
                if (editingEnabled == false) {
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
                             
                             settings.weakValue = preset.weakValue
                             settings.strongValue = preset.strongValue
                         }
                    }
                }
                else {
                    ForEach(userPresets, id: \.self) { preset in
                         NavigationLink {
                             PresetEdit(preset: preset, selectedPresetName: self.$selectedPreset).onAppear() {
                                 exit_presets = false
                             }
                         } label: {
                         Text(preset.name ?? "")
                         }
                    }
                    .onDelete(perform: delete)
                    
                }
            })
        }
        .toolbar {
            NavigationLink(destination: PresetCreate().onAppear() {
                exit_presets = false
            }) {
                Image(systemName: "plus")
            }
            .accessibilityIdentifier("Create New Alarm")
        }
        .onAppear {
            selectedPreset = originalSelected
            settings = controller.getSettings()
            editingEnabled = false
        }
        .onDisappear {
            originalSelected = selectedPreset
            controller.updateSettings(buffer: settings.bufferValue, weak: settings.weakValue, strong: settings.strongValue)
            
            if(exit_presets == true) {
                let settings2 = controller.getSettings()
                print(settings2.weakValue, settings2.strongValue)
                Connectivity.shared.SettingsChanged = Connectivity.SettingsInfo(bufferValue: settings2.bufferValue, weakValue: settings2.weakValue, strongValue: settings2.strongValue)
                Connectivity.shared.send(bufferValue: 10, strongValue: settings2.strongValue, weakValue: settings2.weakValue, delivery: .guaranteed)
            } else {
                exit_presets = true
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
                let preset = userPresets[index]
                if (preset.name == selectedPreset) {
                    selectedPreset = "No Preset"
                }
                moc.delete(preset)
            }
        try? moc.save()
    }
}

//no previews available for this page due to how it takes a binding from SettingsView
