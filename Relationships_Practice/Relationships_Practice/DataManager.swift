//
//  DataManager.swift
//  Relationships_Practice
//
//  Created by Cam on 8/19/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()  // Singleton
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully!")
        } catch let error {
            print("Error saving core data: \(error.localizedDescription)")
        }
    }
}
