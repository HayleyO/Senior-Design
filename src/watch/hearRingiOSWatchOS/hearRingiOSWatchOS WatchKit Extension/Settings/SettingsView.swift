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
    @State var weakValue: Double = 50.0
    @State var strongValue: Double = 90.0
    @State var thresholdBuffer: Double = 10.0
    
    @StateObject var shared = Connectivity.shared
    
    @StateObject var controller = DataController.Controller
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    var body: some View {
        VStack{
            Text("Low Threshold: \(Int(round(weakValue)))")
            Slider(value: $weakValue,
                   in: 0.0...strongValue-thresholdBuffer)
                .accentColor(.yellow)
                .onChange(of: weakValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.low, highThreshold: strongValue)
                }
            Text("High Threshold: \(Int(round(strongValue)))")
            Slider(value: $strongValue,
               in: weakValue+thresholdBuffer...120.0)
                .accentColor(.red)
                .onChange(of: strongValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.high, lowThreshold: weakValue)
                }
        }
        // Do NOT pull thresholdBuffer from connectivity
        .onAppear{
            settings = controller.getSettings()
            
            weakValue = settings.weakValue
            strongValue = settings.strongValue
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
