//
//  ConfigurationRecipe.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 30/01/2022.
//

import Foundation

struct ConfigureRecipeDetails {
    
    func intToStringYield(_ yield: Int) -> String {
        if yield == 0 {
            return "0"
        } else {
            let numberOfPeople = "Serve " + String(yield)
            return numberOfPeople
        }
    }
    
     func minutesToHoursAndMinutes (_ minutes : Int) -> String {
        let time = (minutes / 60, (minutes % 60))
        let cookTime: String
        let hours = time.0
        let minutes = time.1
        if hours > 0  {
            cookTime = "\(hours)h \(minutes)m"
        }
        else if hours == 0 && minutes > 0 {
            cookTime = "\(minutes)m"
        } else {
            cookTime = ""
        }
        return cookTime
    }
    
    func appendUnwrapIngredients(_ optionalIngredients: [Ingredients?]) -> String {
        var ingredientsArray = [String]()
        for i in 0..<optionalIngredients.count {
            let ingredient = optionalIngredients[i]!.food!
            ingredientsArray.append(ingredient)
        }
        let ingredientString = ingredientsArray.joined(separator: ", ")
        return ingredientString
    }
}