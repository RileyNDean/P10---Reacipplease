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
            let recipe = Recipe(cookIngredientsLines: ingredientsList(responseJSON.hits[i]!.recipe!.ingredientLines.compactMap {$0}),
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
    
    func createRecipeForCoreDataCell(with recipeList: RecipesList) -> Recipe {
        let recipe = Recipe(cookIngredientsLines: recipeList.ingredientsLines!,
                            ingredients: recipeList.ingredients!,
                            label: recipeList.title!,
                            cookImage: recipeList.image!,
                            totalTime: recipeList.time!,
                            cookUrl: recipeList.urlRecipe!,
                            cookUri: recipeList.uriRecipe!,
                            yield: recipeList.yield!)
        return recipe
    }
    
    private func ingredientsList(_ ingredients: [String]) -> String {
       var ingredientsList = ""
       for i in 0..<ingredients.count {
           ingredientsList = ingredientsList + "⊛ " + ingredients[i] + "\n"
       }
       return ingredientsList
   }
}

struct Recipe {
    let cookIngredientsLines: String
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
    var ingredientsLines: String { return cookIngredientsLines }
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
    var ingredientsLines: String{ get }
    var url: String { get }
    var uri: String { get }
}
