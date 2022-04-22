//
//  ContentView.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject var sharedData = Connectivity.shared
    @ObservedObject var dataModel = Chunking()
    
    var body: some View {
        VStack {
            let recordModel = Record(chunker: dataModel)
            ProgressView("Recording...", value: dataModel.decibel, total: 160).progressViewStyle(LinearProgressViewStyle(tint: dataModel.tintColor))
                
                .onAppear() {
                    DispatchQueue.main.async {
                        recordModel.setup()
                        recordModel.start()
                    }
                }
            
            Text("This will be where the sound recognition goes.")
            /*Text(sharedData.AlarmChanged.alarmName)
            Text(String(sharedData.AlarmChanged.alarmEnabled))*/
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
