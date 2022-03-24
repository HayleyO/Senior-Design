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
                            newThreshold in sliderChanged(value: newThreshold, slider: sliders.low)
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
                            newThreshold in sliderChanged(value: newThreshold, slider: sliders.high)
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
            weakerValue = shared.SettingsChanged.weakValue
            strongerValue = shared.SettingsChanged.strongValue
            separatorValue = shared.SettingsChanged.bufferValue
        }
    }
    func sliderChanged(value: Double, slider: sliders){
        print("slider value changed to \(value)")
        if(slider == sliders.low){
            controller.updateSettings(buffer: 10, weak: value, strong: strongerValue)
            shared.send(bufferValue: 10, strongValue: strongerValue, weakValue: value, delivery: .highPriority)
        } else if (slider == sliders.high){
            controller.updateSettings(buffer: 10, weak: weakerValue, strong: value)
            shared.send(bufferValue: 10, strongValue: value, weakValue: weakerValue, delivery: .highPriority)
        }
    }
}

enum sliders{
    case low
    case high
}
