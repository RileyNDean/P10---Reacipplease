//
//  Recipes.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 21/01/2022.
//

import Foundation

class Recipes {

    private(set) var recipesArray = [Recipe]()
    
    var responseIsEmpty: Bool {
        return recipesArray.count == 0
    }
    
 
    func createRecipesArray(_ responseJSON: SearchJSONStructure) {
        let configureRecipe = ConfigureRecipeDetails()
        
        for i in 0..<responseJSON.hits.count {
            let recipe = Recipe(cookIngredientsLines: responseJSON.hits[i]!.recipe!.ingredientLines.compactMap {$0},
                                ingredients: configureRecipe.appendUnwrapIngredients((responseJSON.hits[i]?.recipe!.ingredients)!),
                                label: (responseJSON.hits[i]?.recipe?.label)!,
                                cookImage: (responseJSON.hits[i]?.recipe?.image)!,
                                totalTime: configureRecipe.minutesToHoursAndMinutes((responseJSON.hits[i]?.recipe?.totalTime)!),
                                cookUrl: (responseJSON.hits[i]?.recipe?.url)!,
                                cookUri: (responseJSON.hits[i]?.recipe?.uri)!,
                                yield: configureRecipe.intToStringYield((responseJSON.hits[i]?.recipe?.yield)!))
            recipesArray.append(recipe)
        }
    }

}
struct Recipe {
    let cookIngredientsLines: [String]
    let ingredients: String
    let label: String
    let cookImage: String
    let totalTime: String
    let cookUrl: String
    let cookUri: String
    let yield: String
}
extension Recipe: ListedRecipe
{
    var image: String { return cookImage }
    var ingredientsLines: [String] { return cookIngredientsLines }
    var url: String { return cookUrl }
    var uri: String { return cookUri }
    var name: String { return label }
    var time: String { return totalTime }
    var ingredient: String { return ingredients }
    var serve: String { return yield }
    
}


protocol ListedRecipe
{
    var name: String { get }
    var time: String { get }
    var image: String { get }
    var ingredient: String { get }
    var serve: String { get }
    var ingredientsLines: [String] { get }
    var url: String { get }
    var uri: String { get }
}

/*
 let ingredientsLines: [[String]]
 let ingredients: [String]
 let label: [String]
 let image: [String]
 let totalTime: [String]
 let url: [String]
 let uri: [String]
 let yield: [String]
 let numberOfSections: Int
 
 private init(
     ingredientsLines: [[String]],
     ingredients: [String],
     label: [String],
     image: [String],
     totalTime: [String],
     url: [String],
     uri: [String],
     yield: [String],
     numberOfSections: Int)
 {
     self.ingredientsLines = ingredientsLines
     self.ingredients = ingredients
     self.label = label
     self.image = image
     self.totalTime = totalTime
     self.url = url
     self.uri = uri
     self.numberOfSections = numberOfSections
     self.yield = yield
 }
 
 
 static func from(_ responseJSON: SearchJSONStructure) -> Recipes
 {
     let configureRecipe = ConfigureRecipeDetails()
     var ingredientsLines = [[String]]()
     var ingredients = [String]()
     var label = [String]()
     var image = [String]()
     var totalTime = [String]()
     var url = [String]()
     var uri = [String]()
     var yield = [String]()
     
     for i in 0..<responseJSON.hits.count {
         label.append((responseJSON.hits[i]?.recipe?.label)!)
         ingredientsLines.append(responseJSON.hits[i]!.recipe!.ingredientLines.compactMap {$0})
         totalTime.append(configureRecipe.minutesToHoursAndMinutes((responseJSON.hits[i]?.recipe?.totalTime)!))
         url.append((responseJSON.hits[i]?.recipe?.url)!)
         ingredients.append(configureRecipe.appendUnwrapIngredients((responseJSON.hits[i]?.recipe!.ingredients)!))
         image.append((responseJSON.hits[i]?.recipe?.image)!)
         uri.append((responseJSON.hits[i]?.recipe?.uri)!)
         yield.append(configureRecipe.intToStringYield((responseJSON.hits[i]?.recipe?.yield)!))
     }
     
     return Recipes(ingredientsLines: ingredientsLines,
                    ingredients: ingredients,
                    label: label,
                    image: image,
                    totalTime: totalTime,
                    url: url,
                    uri: uri,
                    yield: yield,
                    numberOfSections: responseJSON.hits.count
                    )
 }
 
 
 */






