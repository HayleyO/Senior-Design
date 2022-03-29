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
    @StateObject var shared = Connectivity.shared
    @StateObject var controller = DataController()
    @StateObject var slidercontroller = SettingsSliderController()
    @State var settings: ThresholdEntity = ThresholdEntity()
    
    var body: some View {
        VStack{
            Text("Low Threshold: \(Int(round(weakValue)))")
            Slider(value: $weakValue,
                   in: 0.0...strongValue, step:10)
                .accentColor(.yellow)
                .onChange(of: weakValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.low, highThreshold: strongValue)
                }
            Text("High Threshold: \(Int(round(strongValue)))")
            Slider(value: $strongValue,
               in: weakValue...120.0, step: 10)
                .accentColor(.red)
                .onChange(of: strongValue){
                    newThreshold in slidercontroller.sliderChanged(value: newThreshold, slider: sliders.high, lowThreshold: weakValue)
                }
        }
        .onAppear{
            settings = controller.getSettings()
            weakValue = shared.SettingsChanged.weakValue
            strongValue = shared.SettingsChanged.strongValue
        }
    }
        
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
