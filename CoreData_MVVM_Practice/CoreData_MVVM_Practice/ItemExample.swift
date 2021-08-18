//
//  Item.swift
//  CoreData_MVVM_Practice
//
//  Created by Cam on 8/17/21.
//

import Foundation

struct ItemExample: Identifiable {
    let timestamp: Date
    let id: UUID
}


class ViewModel: ObservableObject {
    @Published var items: [Item] = []
    
    {
        didSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        
        let request = Item.fetchRequest()
        do {
            items = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func add() {
        let item = Item(context: PersistenceController.shared.container.viewContext)
        items.append(item)
    }
    
    func update() {
        if let first = items.first {
            first.timestamp = Date()
        }
        
        items[0].timestamp = Date()
    }
}
