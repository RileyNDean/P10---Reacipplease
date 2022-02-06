//
//  FavoriteRecipes.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 24/01/2022.
//

import Foundation
import CoreData

final class FavoriteRecipes {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }
    
    func getRecipes(callback: @escaping ([RecipesList]) -> Void) {
        let request: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
        
        guard let recipes = try? coreDataStack.viewContext.fetch(request) else {
            callback([])
            return
        }
        callback(recipes)
    }
}
