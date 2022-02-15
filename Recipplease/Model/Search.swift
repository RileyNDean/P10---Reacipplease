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
        self.session = Alamofire.Session(configuration: .default)
    }
    
    init(session: Alamofire.Session) {
        self.session = session
    }
    
    private var session: Alamofire.Session

}

extension Search {
    
    func getRecipesResearch(for ingredients: [String], callback: @escaping (Bool, Recipes?) -> Void) {
        
        let researchURL = searchURL(ingredients: ingredients)
        self.session.request(researchURL, method: .get).responseDecodable(of: SearchJSONStructure.self) { (response) in
            switch response.result {
            case .success(_):
                guard let responseJSON = response.value else {
                    callback(false, nil)
                    return
                }
                
              let recipes = Recipes()
              recipes.createRecipesArray(responseJSON)
                callback(true, recipes)
                
            case .failure(_):
                callback(false, nil)
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
