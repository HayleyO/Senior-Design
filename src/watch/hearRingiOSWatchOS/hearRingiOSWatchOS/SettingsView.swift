//
//  OrderView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//
//  Written by Tyler Lane

import SwiftUI

struct SettingsView: View {
    @State private var weakDecibelLevel: Double = 50
    @State private var strongDecibelLevel: Double = 90
    
    var body: some View {
        NavigationView {
            HStack (alignment: .center) {
                VStack (alignment: .center) {
                    // Weak Vibration Slider
                    Text("Weak Vibration Threshold")
                        .font(.body)
                    Slider(value: $weakDecibelLevel, in: 0...strongDecibelLevel-0.1)
                        .accentColor(.yellow)
                        .padding()
                    Text("\(weakDecibelLevel, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                    
                    Divider()
                        .padding()
                    
                    // Strong Vibration Slider
                    Text("Strong Vibration Threshold")
                        .font(.body)
                    Slider(value: $strongDecibelLevel, in: weakDecibelLevel+0.1...120)
                        .accentColor(.red)
                        .padding()
                    Text("\(strongDecibelLevel, specifier: "%.1f") Decibels")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Settings")
        }
        .onAppear() {
            Connectivity.shared.SendFirst()
        }
    }
}
