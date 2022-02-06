//
//  RecipesIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import Foundation
import UIKit
import CoreData

protocol RecipesDetailsDelegate: NSObject {
    func configureRecipeDetails(image: String, title: String, time: String, ingredients: String, serve: String)
    func openDirectionsURL(directions: URL)
 
}

final class RecipeDetails {
    
    var delegate: RecipesDetailsDelegate?
    private var directionsRecipes = String()
    private var whichSegue = Bool()
    private var recipeByFavorite: RecipesList?
    private var recipeBySearch: Recipe?
    var uri = String()
    

    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = CoreDataStack.sharedInstance) {
        self.coreDataStack = coreDataStack
    }
    
    var havedirections: Bool {
        return directionsRecipes != ""
    }
}

//setup the view with the informations
extension RecipeDetails {
    func configureRecipeDetails(whichSegue: Bool, recipeSearch: Recipe?, recipeFavorite: RecipesList?) {
        if whichSegue {
            self.recipeBySearch = recipeSearch
            directionsRecipes = (recipeSearch!.cookUrl)
            uri = recipeSearch!.cookUri
            delegate?.configureRecipeDetails(image: recipeSearch!.cookImage,
                                             title: recipeSearch!.label,
                                             time: recipeSearch!.totalTime,
                                             ingredients: recipeSearch!.ingredients,
                                             serve: recipeSearch!.yield)
        } else {
            self.recipeByFavorite = recipeFavorite
            directionsRecipes = (recipeByFavorite?.urlRecipe)!
            uri = (recipeByFavorite?.uriRecipe)!
            delegate?.configureRecipeDetails(image: recipeByFavorite!.image!, title: recipeByFavorite!.title!, time: recipeByFavorite!.time!, ingredients: recipeByFavorite!.ingredientsLines!, serve: recipeByFavorite!.yield!)
            
        }
        self.whichSegue = whichSegue
    }
    
     private func ingredientsList(_ ingredients: [String]) -> String {
        var ingredientsList = ""
        for i in 0..<ingredients.count {
            ingredientsList = ingredientsList + "⊛ " + ingredients[i] + "\n"
        }
        return ingredientsList
    }
    
    func openDirectionsURL() {
        guard let url = URL(string: directionsRecipes) else {return}
        delegate?.openDirectionsURL(directions: url)
    }
}

// manage favorite 
extension RecipeDetails {
    func addFavorite() {
        let recipe = RecipesList(context: coreDataStack.viewContext)
        let favorite = Favorite(context: coreDataStack.viewContext)
        recipe.ingredientsLines = recipeBySearch!.ingredients
        recipe.time = recipeBySearch!.totalTime
        recipe.urlRecipe = directionsRecipes
        recipe.title = recipeBySearch!.label
        recipe.ingredients = recipeBySearch!.ingredient
        recipe.image = recipeBySearch!.cookImage
        recipe.yield = recipeBySearch!.yield
        recipe.uriRecipe = uri
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
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.uriRecipe)) == %@", uri)
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
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.uriRecipe)) == %@", uri)
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
