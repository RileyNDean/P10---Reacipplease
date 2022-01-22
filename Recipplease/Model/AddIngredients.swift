//
//  AffIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 21/01/2022.
//

import Foundation

protocol AddIngredientsDelegate: NSObject {
    func addingIngredientsDelegate(ingredients: String)
    func cleanIngredientsDelegate()
}

class ManageIngredient {
    
    weak var delegate: AddIngredientsDelegate?
    var ingredients = ""
    
    func addingIngredient(_ ingredientText: String) {
        let ingredientString = ingredients + ingredientText + "\n"
        ingredients = ingredients + ingredientText + "\n"
        Search.ingredients =  ingredientText + " " + Search.ingredients 
        delegate?.addingIngredientsDelegate(ingredients: ingredientString)
    }
    
    func cleanIngredients () {
        ingredients = ""
        Search.ingredients = ""
        delegate?.cleanIngredientsDelegate()
    }
}
