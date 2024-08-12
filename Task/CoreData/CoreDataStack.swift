//
//  CoreDataStack.swift
//  Task
//
//  Created by Sahitya on 11/08/24.
//

import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Task")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                // Handle error appropriately (e.g., logging, alerting, retrying)
                print("Error loading persistent stores: \(error)")
            } else {
                print("Persistent store loaded successfully: \(description)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
                throw error
            }
        }
    }
}
