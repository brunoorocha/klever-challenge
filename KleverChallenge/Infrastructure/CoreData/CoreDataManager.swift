//
//  CoreDataManager.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 08/12/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "KleverChallengeDataModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize CoreData: \(error)")
            }
        }
    }
    
    func saveContext() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print(error)
        }
    }
}
