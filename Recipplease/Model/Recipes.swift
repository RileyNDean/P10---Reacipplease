//
//  Recipes.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 21/01/2022.
//

import Foundation
import UIKit

class Recipes {
    static var ingredientsLines = [[String]]()
    static var ingredients = [String]()
    static var label = [String]()
    static var image = [UIImage]()
    static var totalTime = [String]()
    static var url = [String]()
    static var numberOfSections = 0
    
    static var responseIsEmpty: Bool {
        return numberOfSections == 0
    }
    
    func getRecipes(_ recipesResearch: SearchJSONStructure!) {
       resetAllArray()
        for i in 0..<recipesResearch.hits.count {
            Recipes.ingredientsLines.append(appendUnwrapIngredientsLing(recipesResearch.hits[i]!.recipe!.ingredientLines))
            Recipes.ingredients.append(appendUnwrapIngredients((recipesResearch.hits[i]?.recipe!.ingredients)!))
            Recipes.label.append(recipesResearch.hits[i]!.recipe!.label!)
            Recipes.image.append(getImage(recipesResearch.hits[i]!.recipe!.image!))
            Recipes.totalTime.append(minutesToHoursAndMinutes(recipesResearch.hits[i]!.recipe!.totalTime!))
            Recipes.url.append(recipesResearch.hits[i]!.recipe!.url!)
        }
        Recipes.numberOfSections = recipesResearch.hits.count
    }
    
    private func resetAllArray() {
        Recipes.ingredients.removeAll()
        Recipes.label.removeAll()
        Recipes.image.removeAll()
        Recipes.totalTime.removeAll()
        Recipes.ingredientsLines.removeAll()
        Recipes.url.removeAll()
    }
    
    private func appendUnwrapIngredientsLing(_ optionalIngredientsLines: [String?]) -> [String] {
        let ingredientsLinesArray = optionalIngredientsLines.compactMap {$0}
        return ingredientsLinesArray
    }
    
    private func minutesToHoursAndMinutes (_ minutes : Int) -> (String) {
        let time = (minutes / 60, (minutes % 60))
        let cookTime: String
        if time.0 > 0  {
            cookTime = "\(time.0)h \(time.1)m"
        }
        else if time.0 == 0 && time.1 > 0 {
            cookTime = "\(time.1)m"
        } else {
            cookTime = ""
        }
        return cookTime
    }
    
    private func appendUnwrapIngredients(_ optionalIngredients: [Ingredients?]) -> String {
        var ingredientsArray = [String]()
        for i in 0..<optionalIngredients.count {
            let ingredient = optionalIngredients[i]!.food!
            ingredientsArray.append(ingredient)
        }
        let ingredientString = ingredientsArray.joined(separator: ", ")
        return ingredientString
    }
    
    private func getImage(_ imageURLString: String) -> UIImage {
        let imageURL = URL(string: imageURLString)
         let imageData = try! Data(contentsOf: imageURL!)
        if imageData.isEmpty {
            return UIImage(named: "cookBaseImage")!
        } else {
        let image = UIImage(data: imageData)
            return image!
        }
    }
}
