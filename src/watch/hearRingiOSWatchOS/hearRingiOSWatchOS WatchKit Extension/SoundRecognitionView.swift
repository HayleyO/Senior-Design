//
//  SoundRecognitionView.swift
//  
//
//  Created by coes on 4/4/22.
//

import Foundation
import SwiftUI
import AVFoundation

@StateObject var sharedData = Connectivity.shared
@ObservedObject var dataModel = Chunking()

var body: some View {
    VStack {
        ProgressView("Recording...", value: dataModel.decibel, total: 160).progressViewStyle(LinearProgressViewStyle(tint: dataModel.tintColor))
            
            .onAppear() {
                DispatchQueue.main.async {
                    //change the shit in here
                }
            }
        
        Text(sharedData.AlarmChanged.alarmName)
        Text(String(sharedData.AlarmChanged.alarmEnabled))
    }
}
