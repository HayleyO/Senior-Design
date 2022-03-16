//
//  ContentView.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    var body: some View {
        NavigationView {
            HStack(alignment: .top){
                VStack(alignment: .center){
                    Text(speechRecognizer.transcript)
                        .padding()
                }
            }
            .navigationTitle("Listening...")
        }
        .onAppear{
            speechRecognizer.reset()
            speechRecognizer.transcribe()
        }
        .onDisappear{
            speechRecognizer.stopTranscribing()
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
      
    let refreshControl = UIRefreshControl()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.async {
            struct ContentView_Previews: PreviewProvider {
                static var previews: some View {
                    ContentView()
                }
            }
        }
    }
}

/*
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
