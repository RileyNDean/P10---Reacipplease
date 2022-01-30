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
    let recipe: RecipesAllDetails?
}

extension Hits: Decodable {
    enum CodingKeys: String, CodingKey {
        case recipe = "recipe"
    }
}

struct RecipesAllDetails {
    let ingredientLines: [String?]
    let ingredients: [Ingredients?]
    let uri: String?
    let yield: Int?
    let label: String?
    let image: String?
    let totalTime: Int?
    let url: String?
}

extension RecipesAllDetails: Decodable {
    enum CodingKeys: String, CodingKey {
        case ingredientLines = "ingredientLines"
        case ingredients = "ingredients"
        case yield = "yield"
        case label = "label"
        case image = "image"
        case totalTime = "totalTime"
        case url = "url"
        case uri = "uri"
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


