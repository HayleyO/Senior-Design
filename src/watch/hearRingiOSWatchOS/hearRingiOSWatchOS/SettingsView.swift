//
//  OrderView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//
//  Written by Tyler Lane

import SwiftUI

struct SettingsView: View {
    @State private var decibelLevel: Double = 60
    var body: some View {
        HStack {
            VStack {
                Text("Decibel Level Threshold")
                    .font(.body)
                    .frame(alignment: .bottom)
                Slider(value: $decibelLevel, in: 0...120)
                Text("\(decibelLevel, specifier: "%.1f") Decibels")
                    .font(.subheadline)
            }
        }
    }
}
