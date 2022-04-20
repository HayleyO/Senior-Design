//
//  PresetEdit.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 4/8/22.
//
import SwiftUI

struct PresetEdit: View {
    var preset: PresetEntity
    @Binding var selectedPresetName: String
    
    @State private var newName = ""
    @State private var newLow = 50.0
    @State private var newHigh = 90.0
    @State var thresholdBuffer: Double = 10.0
    
    @Environment(\.managedObjectContext) var moc
    @State var controller = DataController.Controller
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    var body: some View {
        VStack {
            TextField("Please enter a name", text: $newName,
                prompt: Text(preset.name ?? "Provide a name")
                )
                .font(.title)
                .padding()
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            // Weak Vibration Slider
            Text("Weak Vibration Threshold")
                .font(.body)
            Slider(value: $newLow, in: 0.0...newHigh-thresholdBuffer)
                .accentColor(.yellow)
                .padding()
            Text("\(newLow, specifier: "%.1f") Decibels")
                .font(.subheadline)
           
            Divider()
                .padding()
           
            // Strong Vibration Slider
            Text("Strong Vibration Threshold")
                .font(.body)
            Slider(value: $newHigh, in: newLow+thresholdBuffer...120.0)
                .accentColor(.red)
                .padding()
            Text("\(newHigh, specifier: "%.1f") Decibels")
                .font(.subheadline)
        }
        .onAppear {
            newName = preset.name ?? ""
            newLow = preset.weakValue
            newHigh = preset.strongValue
        }
        .onDisappear {
            if (preset.name == selectedPresetName) {
                selectedPresetName = newName
                
                settings = controller.getSettings()
                settings.weakValue = newLow
                settings.strongValue = newHigh
                print(newLow, newHigh)
                controller.updateSettings(buffer: thresholdBuffer, weak: preset.weakValue, strong: preset.strongValue)
                
            }
            
            preset.name = newName
            preset.weakValue = newLow
            preset.strongValue = newHigh
            print(newLow, newHigh)
            try? moc.save()
        }
    }
}

//no previews for this because of binding
