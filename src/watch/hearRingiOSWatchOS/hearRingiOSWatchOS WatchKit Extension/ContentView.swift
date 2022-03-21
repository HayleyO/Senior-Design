//
//  ContentView.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = Chunking()
    @StateObject var sharedData = Connectivity.shared
    
    var body: some View {
        VStack {
            ProgressView("Recording...", value: dataModel.decibel, total: 160).progressViewStyle(LinearProgressViewStyle(tint: dataModel.tintColor))
                .onAppear() {
                    DispatchQueue.global().async {
                        DispatchQueue.main.async {
                            let recordModel = Record(chunker: dataModel)
                            recordModel.setup()
                            recordModel.start()
                        }
                    }
                }
            Text(sharedData.AlarmChanged.alarmName)
            Text(String(sharedData.AlarmChanged.alarmEnabled))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
