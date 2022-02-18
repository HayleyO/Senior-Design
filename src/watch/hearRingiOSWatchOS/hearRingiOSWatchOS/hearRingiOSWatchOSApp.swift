//
//  hearRingiOSWatchOSApp.swift
//  hearRingiOSWatchOS
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI

@main
struct hearRingiOSWatchOSApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
