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
    let soundrec = soundRecognizer()
    var message:String!
    
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
          
            let val = soundrec.analyzeAudio(buffer:at:)
            let out:String = soundrec.out ?? ""
            let message = "The watch is hearing: \n" + out
        
            Text(message)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
