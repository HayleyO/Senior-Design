//
//  Chunking.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/15/22.
//

import Foundation
import SwiftUI

class Chunking: NSObject, ObservableObject{
    @Environment(\.managedObjectContext) var moc
    @Published var decibel: Double = 0
    @Published var tintColor: Color = .green
    
    func getColorFromDecibel() -> Color {
       // let thresholds = ThresholdEntity(context: moc)
        if decibel <=  50.0{
            print("threshold")
            return Color.green
        }
        else if decibel < 90.0{
            print("threshold ")
            return Color.yellow
        }
        else{
            return Color.red
        }
    }

}
