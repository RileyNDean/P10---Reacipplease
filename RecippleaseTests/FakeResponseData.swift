//
//  FakeResponseData.swift
//  RecippleaseTests
//
//  Created by Dhayan Bourguignon on 06/02/2022.
//

import Foundation

class FakeResponseData {
    
    static let responseOK = HTTPURLResponse(url: URL(string: "http://")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseKO = HTTPURLResponse(url: URL(string: "http://")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
 
    static var recipeCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "recipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let recipeIncorrectData = "error".data(using: .utf8)!
    
    class APIError: Error {}
    static let error = APIError()
}
