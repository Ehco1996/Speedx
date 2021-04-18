//
//  SpeedXApp.swift
//  Shared
//
//  Created by ehco on 2021/4/18.
//

import SwiftUI

@main
struct SpeedXApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
