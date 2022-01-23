//
//  Search.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 19/01/2022.
//

import Foundation

final class Search {
    static var ingredients = ""
    
    static var ingredientsListIsEmpty: Bool {
        return ingredients == ""
    }
    
    static var shared = Search()
    private init() {
        self.searchSession = URLSession(configuration: .default)
    }
    
    private var task: URLSessionDataTask?
    private var searchSession: URLSession
    
    init(searchSession: URLSession){
        self.searchSession = searchSession
    }
}

extension Search {
    
    func getResearch(callback: @escaping (Bool, Recipes?) -> Void) {
        
        let researchURL = searchURL()
        
        task?.cancel()
        task = searchSession.dataTask(with: researchURL) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(SearchJSONStructure.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let recipes = Recipes()
                recipes.getRecipes(responseJSON)
                callback(true, recipes)
            }
        }
        task?.resume()
    }
    
    private func searchURL() -> URL {
        let searchAPI = "https://api.edamam.com/api/recipes/v2?"
        let appKey = "f99138a06912b8af3245621c660d2149"
        let appID = "bdd0d7aa"
        let q = Search.ingredients.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let type = "public"
        let searchURL = URL(string: searchAPI + "q=" + q + "&app_id=" + appID + "&app_key=" + appKey + "&type=" + type)
        return searchURL!
    }
}

