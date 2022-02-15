//
//  Chunking.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/15/22.
//

import Foundation
import SwiftUI

class Chunking: NSObject, ObservableObject{
    @Published var decibel: Float = 0

    @Published var tintColor: Color = .green
    
    func getColorFromDecibel() -> Color {
        if decibel <= 50.0{
            return Color.green
        }
        else if decibel < 90.0{
            return Color.yellow
        }
        else{
            return Color.red
        }
    }

}
