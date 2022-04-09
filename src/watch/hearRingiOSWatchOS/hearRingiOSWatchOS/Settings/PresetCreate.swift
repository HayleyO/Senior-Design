//
//  PresetCreate.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 4/7/22.
//

import SwiftUI

struct PresetCreate: View {
    @State private var newName = ""
    @State private var newLow = 50.0
    @State private var newHigh = 90.0
    @State var thresholdBuffer: Double = 10.0
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Form {
                TextField(text: $newName, prompt: Text("Name your new preset")) {
                    Text("Name")
                }
                .padding()
                VStack {
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
                .padding()
            }
            Button("Save", action: { self.presentationMode.wrappedValue.dismiss()
                let newpreset = PresetEntity(context: moc)
                        newpreset.id = UUID()
                        newpreset.name = newName
                        newpreset.strongValue = newHigh
                        newpreset.weakValue = newLow
                try? moc.save()
                }
            )
                .padding()
            
            Divider()
                .padding()
        }
    }
}

struct PresetCreate_Previews: PreviewProvider {
    static var previews: some View {
        PresetCreate()
    }
}
