//
//  FavoriteDetails.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 24/01/2022.
//

import Foundation
import UIKit
import CoreData

final class FavoriteDetail {
    
    var delegate: RecipesDetails?
    private var recipe: RecipesList?
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }
    
    var havedirections: Bool {
        return recipe?.url != ""
    }
    
    func configureFavorite(recipe: RecipesList) {
        self.recipe = recipe
        delegate?.configureRecipeDetails(image: UIImage(data: recipe.image!)!, title: recipe.title!, time: recipe.time!, ingredients: recipe.ingredientsLines!)
    }
    
    func openDirectionsURL() {
        guard let url = URL(string: (self.recipe?.url!)!) else {return}
        delegate?.openDirectionsURL(directions: url)
    }
    
    func remove() {
        guard let recipe = self.recipe else {return}
        coreDataStack.viewContext.delete(recipe)
        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("We were unable to remove \(recipe.description)")
        }
    }
}
