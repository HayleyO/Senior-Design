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
    //this call of DataController() may be what is throwing the coredata errors, need to investigate further but outside of scope for this card
    @StateObject var controller = DataController.Controller
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()

    @State var selectedPreset: String = "No Preset"
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    NavigationLink {
                        PresetsView(originalSelected: self.$selectedPreset)
                    } label : {
                        HStack {
                            Text("Preset")
                            Spacer()
                            Text(selectedPreset)
                                .font(.subheadline)
                        }
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
            weakValue = settings.weakValue
            strongValue = settings.strongValue
            thresholdBuffer = settings.bufferValue
        }
        .onChange(of: shared.SettingsChanged) { Settings in
            slidercontroller.updated_from_connectivity = true
            
            weakValue = Settings.weakValue
            strongValue = Settings.strongValue
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
