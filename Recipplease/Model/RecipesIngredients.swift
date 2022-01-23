//
//  RecipesIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import Foundation
import UIKit
import CoreData

final class RecipeManageDetails {
    
    var delegate: RecipesDetails?
    private var directionsRecipes: String?
    private var title: String?
    private var image: UIImage?
    private var time: String?
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
         ingredients = ingredientsList(Recipes.ingredientsLines[indexRecipes])
        directionsRecipes = Recipes.url[indexRecipes]
        delegate?.configureRecipeDetails(image: image!, title: title!, time: time!, ingredients: ingredients!)
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
        recipe.ingredients = ingredients
        recipe.time = time
        recipe.url = directionsRecipes
        recipe.title = title
        recipe.image = image?.jpegData(compressionQuality: 1.0)
        favorite.isFavorite = true
        recipe.isFavorite = favorite
        do {
            try coreDataStack.viewContext.save()
        } catch {
            print("We were unable to remove \(recipe.description)")
        }
    }
    
    func remove() {
        let ingredientsRequest: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.ingredients)) == %@", ingredients!)
        if let recipe = try? coreDataStack.viewContext.fetch(ingredientsRequest) {
            for object in recipe {
                coreDataStack.viewContext.delete(object)
            }
        }
    }
    
    func isAlreadyFavorite() -> Bool {
        let ingredientsRequest: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
        ingredientsRequest.predicate = NSPredicate(format: "\(#keyPath(RecipesList.ingredients)) == %@", ingredients!)
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

protocol RecipesDetails: NSObject {
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String)
    func openDirectionsURL(directions: URL)
 
}

/*
 func deleteAllData() {
     let fetchRequest: NSFetchRequest<RecipesList> = RecipesList.fetchRequest()
     fetchRequest.returnsObjectsAsFaults = false
     do {
         let results = try coreDataStack.viewContext.fetch(fetchRequest)
         for object in results {
             guard let objectData = object as? NSManagedObject else {continue}
             coreDataStack.viewContext.delete(objectData)
         }
     } catch let error {
         print("Detele all data in error :", error)
     }
 }
 */
