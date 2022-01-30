//
//  AffIngredients.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 21/01/2022.
//

import Foundation

protocol AddIngredientsDelegate: NSObject {
    func addingIngredientsDelegate(ingredients: [String])
    func cleanIngredientsDelegate()
}

final class ManageIngredient {
    
    weak var delegate: AddIngredientsDelegate?
    var ingredients = [String]()
    
    func addingIngredient(_ ingredientText: String) {
        ingredients.append(ingredientText)
        delegate?.addingIngredientsDelegate(ingredients: ingredients)
    }
    
    func cleanIngredients() {
        ingredients = []
        delegate?.cleanIngredientsDelegate()
    }
}
