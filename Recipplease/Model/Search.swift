//
//  Search.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 19/01/2022.
//

import Foundation
import Alamofire

final class Search {
    
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
    
    func getRecipesResearch(for ingredients: [String], callback: @escaping (Bool, Recipes?) -> Void) {
        
        let researchURL = searchURL(ingredients: ingredients)
        
        DispatchQueue.main.async {
            AF.request(researchURL, method: .get).responseDecodable(of: SearchJSONStructure.self) { (response) in
                if response.error != nil  {
                      callback(false, nil)
                    print(response.error)
                      return
                  }
                  guard let responseJSON = response.value else {
                      callback(false, nil)
                      print(response.value)
                      return
                  }
                  let recipes = Recipes.from(responseJSON)
                  callback(true, recipes)
            }
        }
    }
    
    private func searchURL(ingredients: [String]) -> URL {
        let searchAPI = "https://api.edamam.com/api/recipes/v2?"
        let appKey = "f99138a06912b8af3245621c660d2149"
        let appID = "bdd0d7aa"
        let q = ingredients.joined(separator: " ").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let type = "public"
        let searchURL = URL(string: searchAPI + "q=" + q + "&app_id=" + appID + "&app_key=" + appKey + "&type=" + type)
        return searchURL!
    }
}

/*
 AF.request(researchURL, method: .get).responseDecodable(of: SearchJSONStructure.self) { (response) in
     if response.error == nil  {
           callback(false, nil)
         print(response.error)
           return
       }
       guard let responseJSON = response.value else {
           callback(false, nil)
           print(response.value)
           return
       }
       let recipes = Recipes.from(responseJSON)
       callback(true, recipes)
 }
 */
