//
//  hearRing_v12_4App.swift
//  Shared
//
//  Created by coes on 3/16/22.
//

import SwiftUI

@main
struct hearRing_v12_4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
