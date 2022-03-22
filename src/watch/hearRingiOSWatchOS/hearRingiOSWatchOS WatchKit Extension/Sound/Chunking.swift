//
//  Chunking.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/15/22.
//

import Foundation
import SwiftUI

class Chunking: NSObject, ObservableObject{
    var controller = DataController()
    @Published var decibel: Double = 0
    @Published var tintColor: Color = .green
    
    func getColorFromDecibel() -> Color {
        let thresholds = controller.getSettings()
        if decibel <=  thresholds.weakValue{
            return Color.green
        }
        else if decibel < thresholds.strongValue{
            return Color.yellow
        }
        else{
            return Color.red
        }
    }

}
