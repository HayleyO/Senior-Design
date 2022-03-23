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
    @StateObject var controller = DataController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
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
        .onAppear{
            settings = controller.getSettings()
            lowThreshold = shared.SettingsChanged.weakValue
            highThreshold = shared.SettingsChanged.strongValue
        }
    }
    
    func sliderChanged(value: Double, slider: sliders){
        print("slider value changed to \(value)")
        if(slider == sliders.low){
            controller.updateSettings(buffer: 0.1, weak: value, strong: highThreshold)
            shared.send(bufferValue: 0.1, strongValue: highThreshold, weakValue: value, delivery: .highPriority)
        }
        else if(slider == sliders.high){
            controller.updateSettings(buffer: 0.1, weak: lowThreshold, strong: value)
            shared.send(bufferValue: 0.1, strongValue: value, weakValue: lowThreshold, delivery: .highPriority)
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
