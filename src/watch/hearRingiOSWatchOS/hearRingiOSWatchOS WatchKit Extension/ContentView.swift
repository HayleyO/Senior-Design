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
        let recordModel = Record(chunker: dataModel)
        VStack {
            ProgressView("Recording...", value: dataModel.decibel, total: 160).progressViewStyle(LinearProgressViewStyle(tint: dataModel.tintColor))
            
                .onAppear() {
                    recordModel.setup()
                    recordModel.start()
                }
                .onDisappear(){
                    recordModel.stop()
                }
            Text(sharedData.strr)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
