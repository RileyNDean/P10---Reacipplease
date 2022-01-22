//
//  RecipesIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import Foundation
import UIKit

class RecipeIngredients {
    
    var delegate: RecipesDetails?
    
    func configureRecipeDetails(_ indexRecipes: Int) {
        let title = Recipes.label[indexRecipes]
        print(title)
        let image = Recipes.image[indexRecipes]
        let time = Recipes.totalTime[indexRecipes]
        let ingredients = ingredientsList(Recipes.ingredientsLines[indexRecipes])
        delegate?.configureRecipeDetails(image: image, title: title, time: time, ingredients: ingredients)
    }
    
    private func ingredientsList(_ ingredients: [String]) -> String {
        var ingredientsList = ""
        for i in 0..<ingredients.count {
            ingredientsList = ingredientsList + "⊛ " + ingredients[i] + "\n"
        }
        return ingredientsList
    }
    
}

protocol RecipesDetails: NSObject {
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String)
}
