//
//  SettingsView.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 3/13/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var settingsModel = SettingsModel()
    @State var lowThreshold = 50.0
    @State var highThreshold = 90.0
    
    var body: some View {
        VStack{
            Text("Low Threshold: \(Int(round(lowThreshold)))")
        Slider(value: $lowThreshold,
               in: 0...highThreshold,
               onEditingChanged: {_ in settingsModel.lowThreshold = lowThreshold})
                .accentColor(.yellow)
            Text("High Threshold: \(Int(round(highThreshold)))")
        Slider(value: $highThreshold,
               in: lowThreshold...120,
               onEditingChanged: {_ in settingsModel.highThreshold = highThreshold})
                .accentColor(.red)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
