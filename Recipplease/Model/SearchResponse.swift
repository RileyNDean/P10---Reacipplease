//
//  SearchJSONStructure.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 19/01/2022.
//

import Foundation
import UIKit

struct SearchJSONStructure {
    let hits: [Hits?]
}

extension SearchJSONStructure: Decodable {
    enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
}

struct Hits {
    let recipe: Recipe?
}

extension Hits: Decodable {
    enum CodingKeys: String, CodingKey {
        case recipe = "recipe"
    }
}

struct Recipe {
    let ingredientLines: [String?]
    let ingredients: [Ingredients?]
    let label: String?
    let image: String?
    let totalTime: Double?
    let url: String?
}

extension Recipe: Decodable {
    enum CodingKeys: String, CodingKey {
        case ingredientLines = "ingredientLines"
        case ingredients = "ingredients"
        case label = "label"
        case image = "image"
        case totalTime = "totalTime"
        case url = "url"
    }
}

struct Ingredients {
    let food: String?
}

extension Ingredients: Decodable {
    enum CodingKeys: String, CodingKey {
        case food = "food"
    }
}


class RecipeSearch {
    static var ingredientsLines = [[String]]()
    static var ingredients = [String]()
    static var label = [String]()
    static var image = [UIImage]()
    static var totalTime = [Double]()
    static var url = [String]()
    static var numberOfSections = 0
    
    func getRecipes(_ recipesResearch: SearchJSONStructure!) {
        for i in 0..<recipesResearch.hits.count {
            RecipeSearch.ingredientsLines.append(appendUnwrapIngredientsLing(recipesResearch.hits[i]!.recipe!.ingredientLines))
            RecipeSearch.ingredients.append(appendUnwrapIngredients((recipesResearch.hits[i]?.recipe!.ingredients)!))
            RecipeSearch.label.append(recipesResearch.hits[i]!.recipe!.label!)
            RecipeSearch.image.append(getImage(recipesResearch.hits[i]!.recipe!.image!))
            RecipeSearch.totalTime.append(recipesResearch.hits[i]!.recipe!.totalTime!)
            RecipeSearch.url.append(recipesResearch.hits[i]!.recipe!.url!)
        }
        RecipeSearch.numberOfSections = recipesResearch.hits.count
    }
    
    func appendUnwrapIngredientsLing(_ optionalIngredientsLines: [String?]) -> [String] {
        let ingredientsLinesArray = optionalIngredientsLines.compactMap {$0}
        return ingredientsLinesArray
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
    
    func getImage(_ imageURLString: String) -> UIImage {
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
