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
    func configureRecipeDetails(image: String, title: String, time: String, ingredients: String)
    func openDirectionsURL(directions: URL)
 
}

final class RecipeDetails {
    
    var delegate: RecipesDetailsDelegate?
    private var directionsRecipes = String()
    private var title = String()
    private var image = String()
    private var time = String()
    private var ingredientsLines = String()
    private var ingredients = String()
    private var recipeIndex = Int()
    private var whichSegue = Bool()
    private var recipe: RecipesList?
    private var uri = String()
    private var yield = String()

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
    func configureRecipeDetails(whichSegue: Bool,recipeIndex: Int, recipeSearch: Recipes?, recipeFavorite: RecipesList?) {
        print(whichSegue)
        if whichSegue {
            directionsRecipes = (recipeSearch?.url[recipeIndex])!
            ingredients = (recipeSearch?.ingredients[recipeIndex])!
            image = (recipeSearch?.image[recipeIndex])!
            title = (recipeSearch?.label[recipeIndex])!
            time = (recipeSearch?.totalTime[recipeIndex])!
            uri = (recipeSearch?.uri[recipeIndex])!
            yield = (recipeSearch?.yield[recipeIndex])!
            ingredientsLines = ingredientsList((recipeSearch?.ingredientsLines[recipeIndex])!)
            delegate?.configureRecipeDetails(image: (recipeSearch?.image[recipeIndex])!, title: (recipeSearch?.label[recipeIndex])!, time: (recipeSearch?.totalTime[recipeIndex])!, ingredients: ingredientsList((recipeSearch?.ingredientsLines[recipeIndex])!))
        } else {
            self.recipe = recipeFavorite
            directionsRecipes = (recipe?.urlRecipe)!
            uri = (recipe?.uriRecipe)!
            delegate?.configureRecipeDetails(image: recipe!.image!, title: recipe!.title!, time: recipe!.time!, ingredients: recipe!.ingredientsLines!)
            
        }
        self.whichSegue = whichSegue
        self.recipeIndex = recipeIndex
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

// favorite ee
extension RecipeDetails {
    func addFavorite() {
        let recipe = RecipesList(context: coreDataStack.viewContext)
        let favorite = Favorite(context: coreDataStack.viewContext)
        recipe.ingredientsLines = ingredientsLines
        recipe.time = time
        recipe.urlRecipe = directionsRecipes
        recipe.title = title
        recipe.ingredients = ingredients
        recipe.image = image
        recipe.yield = yield
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
