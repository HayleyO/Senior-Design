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
    @State var weakerValue: Double = 50.0
    @State var strongerValue: Double = 90.0
    @State var thresholdBuffer: Double = 10.0
    
    @StateObject var shared = Connectivity.shared
    
    @StateObject var controller = DataController()
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    var body: some View {
        VStack{
            Text("Low Threshold: \(Int(round(weakerValue)))")
            Slider(value: $weakerValue,
                   in: 0.0...strongerValue-thresholdBuffer)
                .accentColor(.yellow)
                .onChange(of: weakerValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.low, highThreshold: strongerValue)
                }
            Text("High Threshold: \(Int(round(strongerValue)))")
            Slider(value: $strongerValue,
               in: weakerValue+thresholdBuffer...120.0)
                .accentColor(.red)
                .onChange(of: strongerValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.high, lowThreshold: weakerValue)
                }
        }
        // Do NOT pull thresholdBuffer from connectivity
        .onAppear{
            settings = controller.getSettings()
        }
        .onChange(of: shared.SettingsChanged) { Settings in
            slidercontroller.updated_from_connectivity = true
            
            weakerValue = Settings.weakValue
            strongerValue = Settings.strongValue
            
            print("Weak and strong values changed: ")
            print(weakerValue)
            print(strongerValue)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
