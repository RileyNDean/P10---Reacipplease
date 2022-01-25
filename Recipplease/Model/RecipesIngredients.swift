//
//  RecipesIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import Foundation
import UIKit
import CoreData

protocol RecipesDetails: NSObject {
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String)
    func openDirectionsURL(directions: URL)
 
}

final class RecipeManageDetails {
    
    var delegate: RecipesDetails?
    private var directionsRecipes: String?
    private var title: String?
    private var image: UIImage?
    private var time: String?
    private var ingredientsLines: String?
    private var ingredients: String?
    
    
    var recette: [RecipesList] = []
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }
    
    var havedirections: Bool {
        return directionsRecipes != ""
    }
}

//setup the view with the informations
extension RecipeManageDetails {
    func configureRecipeDetails(_ indexRecipes: Int) {
         title = Recipes.label[indexRecipes]
         image = Recipes.image[indexRecipes]
         time = Recipes.totalTime[indexRecipes]
         ingredientsLines = ingredientsList(Recipes.ingredientsLines[indexRecipes])
        directionsRecipes = Recipes.url[indexRecipes]
        ingredients = Recipes.ingredients[indexRecipes]
        delegate?.configureRecipeDetails(image: image!, title: title!, time: time!, ingredients: ingredientsLines!)
    }
    
    private func ingredientsList(_ ingredients: [String]) -> String {
        var ingredientsList = ""
        for i in 0..<ingredients.count {
            ingredientsList = ingredientsList + "⊛ " + ingredients[i] + "\n"
        }
        return ingredientsList
    }
    
    func openDirectionsURL() {
        guard let url = URL(string: directionsRecipes!) else {return}
        delegate?.openDirectionsURL(directions: url)
    }
}

// favorite manage
extension RecipeManageDetails {
    func addFavorite() {
        let recipe = RecipesList(context: coreDataStack.viewContext)
        let favorite = Favorite(context: coreDataStack.viewContext)
        recipe.ingredientsLines = ingredientsLines
        recipe.time = time
        recipe.url = directionsRecipes
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.image = image?.jpegData(compressionQuality: 1.0)
        favorite.isFavorite = true
        recipe.isFavorite = favorite
        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("We were unable to add \(recipe.description)")
        }
    }
    
    func remove() {
        let ingredientsRequest: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.ingredientsLines)) == %@", ingredientsLines!)
        if let recipe = try? coreDataStack.viewContext.fetch(ingredientsRequest) {
            for object in recipe {
                coreDataStack.viewContext.delete(object)
            }
            do {
                try coreDataStack.viewContext.save()
            } catch {
                print("We were unable to remove \(recipe.description)")
            }
        }
    }
    
    func isAlreadyFavorite() -> Bool {
        let ingredientsRequest: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.ingredientsLines)) == %@", ingredientsLines!)
        do {
        let ingredients = try coreDataStack.viewContext.fetch(ingredientsRequest)
            if  ingredients.count == 0 {
                return false
            }
            else {
                return true
            }
        } catch {
           return false
        }
    }
}
