//
//  OrderView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//
//  Written by Tyler Lane

import SwiftUI
import CoreData

struct SettingsView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    @State var weakerValue: Double = 50
    @State var strongerValue: Double = 90
    @State var separatorValue: Double = 10
    
    @StateObject var shared = Connectivity.shared
    @StateObject var controller = DataController()
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    var body: some View {
        NavigationView {
            HStack (alignment: .center) {
                VStack (alignment: .center) {
                    // Weak Vibration Slider
                    Text("Weak Vibration Threshold")
                        .font(.body)
                    Slider(value: $weakerValue, in: 0.0...strongerValue-separatorValue)
                        .accentColor(.yellow)
                        .padding()
                        .onChange(of: weakerValue){
                            newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.low, highThreshold: strongerValue)
                        }
                    Text("\(weakerValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                    
                    Divider()
                        .padding()
                    
                    // Strong Vibration Slider
                    Text("Strong Vibration Threshold")
                        .font(.body)
                    Slider(value: $strongerValue, in: weakerValue+separatorValue...120.0)
                        .accentColor(.red)
                        .padding()
                        .onChange(of: strongerValue){
                            newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.high, lowThreshold: weakerValue)
                        }
                    Text("\(strongerValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                }
            .navigationTitle("Settings")
            }
        }
        .onAppear() {
            Connectivity.shared.SendFirst()
            settings = controller.getSettings()
        }
        .onChange(of: shared.SettingsChanged) { Settings in
            slidercontroller.updated_from_connectivity = true
            
            weakerValue = Settings.weakValue
            strongerValue = Settings.strongValue
            separatorValue = Settings.bufferValue
            
            
            print("Weak and strong values changed: ")
            print(weakerValue)
            print(strongerValue)
        }
    }
}
