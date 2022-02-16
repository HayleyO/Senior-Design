//
//  hearRingiOSWatchOSApp.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hayley Owens on 2/14/22.
//

import SwiftUI

@main
struct hearRingiOSWatchOSApp: App {
    
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
       
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}