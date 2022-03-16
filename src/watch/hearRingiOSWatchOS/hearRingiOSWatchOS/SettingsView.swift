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
    
    @State private var weakerValue: Double = 50
    @State private var strongerValue: Double = 90
    
    var body: some View {
        NavigationView {
            let sliderThreshold = SliderThresholdEntity(context: moc)
            HStack (alignment: .center) {
                VStack (alignment: .center) {
                    // Weak Vibration Slider
                    Text("Weak Vibration Threshold")
                        .font(.body)
                    Slider(value: $weakerValue, in: 0.0...sliderThreshold.strongValue-sliderThreshold.thresholdBuffer)
                    /*
                        .onChange(of:){
                            do {
                                try managedObjectContext.save()
                            } catch {
                                // handle the Core Data error
                            }
                        }
                     */
                        .accentColor(.yellow)
                        .padding()
                    Text("\(weakerValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                    
                    Divider()
                        .padding()
                    
                    // Strong Vibration Slider
                    Text("Strong Vibration Threshold")
                        .font(.body)
                    Slider(value: $strongerValue, in: sliderThreshold.weakValue+sliderThreshold.thresholdBuffer...120.0)
                        .accentColor(.red)
                        .padding()
                    Text("\(strongerValue, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                }
            
            .navigationTitle("Settings")
            }
        }
    }
}

