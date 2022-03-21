//
//  SettingsView.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 3/13/22.
//

import SwiftUI
import CoreData

struct SettingsView: View{
    @Environment(\.managedObjectContext) var moc
    @State var lowThreshold: Double = 50.0
    @State var highThreshold: Double = 90.0
    @StateObject var shared = Connectivity.shared
    
    var body: some View {
        VStack{
            Text("Low Threshold: \(Int(round(lowThreshold)))")
            Slider(value: $lowThreshold,
                   in: 0.0...highThreshold, step:10)
                .accentColor(.yellow)
                .onChange(of: lowThreshold){
                    newThreshold in sliderChanged(value: newThreshold, slider: sliders.low)
                }
            Text("High Threshold: \(Int(round(highThreshold)))")
            Slider(value: $highThreshold,
               in: lowThreshold...120.0, step: 10)
                .accentColor(.red)
                .onChange(of: highThreshold){
                    newThreshold in sliderChanged(value: newThreshold, slider: sliders.high)
                }
        }
    }
    
    func sliderChanged(value: Double, slider: sliders){
        print("slider value changed to \(value)")
        let sliderThreshold = ThresholdEntity(context: moc)
        if(slider == sliders.low){
            shared.send(bufferValue: sliderThreshold.bufferValue, strongValue: sliderThreshold.strongValue, weakValue: value, delivery: .highPriority)
            try? moc.save()
        }
        else if(slider == sliders.high){
            shared.send(bufferValue: sliderThreshold.bufferValue, strongValue: value, weakValue: sliderThreshold.weakValue, delivery: .highPriority)
            try? moc.save()
        }
    }
        
}

enum sliders{
    case low
    case high
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
