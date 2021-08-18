//
//  CoreData_MVVM_PracticeApp.swift
//  CoreData_MVVM_Practice
//
//  Created by Cam on 8/17/21.
//

import SwiftUI

@main
struct CoreData_MVVM_PracticeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
