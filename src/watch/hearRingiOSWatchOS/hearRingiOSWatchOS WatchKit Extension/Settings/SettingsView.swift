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
    
    var body: some View {
        let sliderThreshold = ThresholdEntity(context: moc)
        VStack{
            Text("Low Threshold: \(Int(round(sliderThreshold.weakValue)))")
            Slider(value: $lowThreshold,
                   in: 0.0...sliderThreshold.weakValue, step:10)
                .accentColor(.yellow)
                .onChange(of: lowThreshold){
                    newThreshold in sliderChanged(progress: newThreshold, slider: sliders.low)
                }
            Text("High Threshold: \(Int(round(sliderThreshold.strongValue)))")
        Slider(value: $highThreshold,
               in: sliderThreshold.weakValue...120.0, step: 10)
                .accentColor(.red)
                .onChange(of: highThreshold){
                    newThreshold in sliderChanged(progress: newThreshold, slider: sliders.high)
                }
        }
    }
    
    func sliderChanged(progress: Double, slider: sliders){
        print("slider value changed to \(progress)")
        let sliderThreshold = ThresholdEntity(context: moc)
        if(slider == sliders.low){
            sliderThreshold.setValue(progress, forKey: "weakValue")
            try? moc.save()
        }
        else if(slider == sliders.high){
            sliderThreshold.setValue(progress, forKey: "strongValue")
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
