//
//  Word_list_AppApp.swift
//  Word_list_App
//
//  Created by 김성배 on 2023/05/16.
//

import SwiftUI

@main
struct Word_list_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
