//
//  SearchJSONStructure.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 19/01/2022.
//

import Foundation


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
    let totalTime: Int?
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


