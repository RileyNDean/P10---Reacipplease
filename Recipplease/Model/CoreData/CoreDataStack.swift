//
//  CoreDataStack.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 23/01/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()
    
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Recipplease")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
