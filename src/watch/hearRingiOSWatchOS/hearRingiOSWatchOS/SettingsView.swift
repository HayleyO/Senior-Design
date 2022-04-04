//
//  OrderView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//
//  Written by Tyler Lane.

import SwiftUI
import CoreData

struct SettingsView: View {
    @Environment(\.managedObjectContext) var moc
    @State var weakValue: Double = 50.0
    @State var strongValue: Double = 90.0
    @State var thresholdBuffer: Double = 10.0
    @StateObject var shared = Connectivity.shared
    @StateObject var controller = DataController()
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    enum Preset: String, CaseIterable, Identifiable {
        case indoors, outdoors, resturaunt, sleep
        var id: Self { self }
    }

    @State private var selectedPreset: Preset = .indoors
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Picker("Preset", selection: $selectedPreset) {
                        Text("Indoors").tag(Preset.indoors)
                        Text("Outdoors").tag(Preset.outdoors)
                        Text("Resturaunt").tag(Preset.resturaunt)
                        Text("Sleep").tag(Preset.sleep)
                    }
                }
                VStack {
                    // Weak Vibration Slider
                    Text("Weak Vibration Threshold")
                        .font(.body)
                    Slider(value: $weakValue, in: 0.0...strongValue-thresholdBuffer)
                        .accentColor(.yellow)
                        .padding()
                        .onChange(of: weakValue){
                            newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.low, highThreshold: strongValue)
                        }
                    Text("\(weakValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                   
                    Divider()
                        .padding()
                   
                    // Strong Vibration Slider
                    Text("Strong Vibration Threshold")
                        .font(.body)
                    Slider(value: $strongValue, in: weakValue+thresholdBuffer...120.0)
                        .accentColor(.red)
                        .padding()
                        .onChange(of: strongValue){
                            newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.high, lowThreshold: weakValue)
                        }
                    Text("\(strongValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Settings")
        }
        // Do NOT pull thresholdBuffer from connectivity
        .onAppear() {
            Connectivity.shared.SendFirst()
            settings = controller.getSettings()
            weakValue = shared.SettingsChanged.weakValue
            strongValue = shared.SettingsChanged.strongValue
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
