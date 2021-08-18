//
//  FruitViewModel.swift
//  CoreData_Practice
//
//  Created by Cam on 8/18/21.
//

import Foundation
import CoreData


class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("Successfully loaded core data")
            }
        }
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
         
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching fruits: \(error)")
        }
        
        
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        
        newFruit.name = text
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteFruite(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currrentName = entity.name ?? ""
        let newName = currrentName + "!"
        entity.name = newName
        saveData()
    }
    
}
