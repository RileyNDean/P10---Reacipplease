//
//  RecippleaseTests.swift
//  RecippleaseTests
//
//  Created by Dhayan Bourguignon on 18/01/2022.
//

import XCTest
import Alamofire
import CoreData
@testable import Recipplease

class RecippleaseTests: XCTestCase {
    
    override func tearDown() {
        TestURLProtocol.loadingHandler = nil
    }
    override func setUp() {
        
    }

    func testGetSearchShouldPostFailedCallbackIfIncorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.recipeIncorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Alamofire.Session(configuration: configuration)
        let search = Search(session: sessionManager)
        let ingredient: [String] = ["Tomato"]
        
        let expectation = XCTestExpectation(description: "wait for queu change.")
        search.getRecipesResearch(for: ingredient) { success, recipe in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetSearchShouldPostFailedCallbackIfError() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseKO
            let data: Data? = nil
            let error: Error? = FakeResponseData.error
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Alamofire.Session(configuration: configuration)
        let search = Search(session: sessionManager)
        let ingredient: [String] = ["Tomato"]
        
        let expectation = XCTestExpectation(description: "wait for queu change.")
        search.getRecipesResearch(for: ingredient) { success, recipe in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetSearchShouldPostSuccessCallbackIfNoErrrorAndCorrectData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = FakeResponseData.recipeCorrectData
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Alamofire.Session(configuration: configuration)
        let search = Search(session: sessionManager)
        let ingredient: [String] = ["Tomato"]
        
        let expectation = XCTestExpectation(description: "wait for queu change.")
        search.getRecipesResearch(for: ingredient) { success, recipe in
            
            let uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_1155648f37e539dc36b847ddbf7f53f7"
            
            
            
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            
            XCTAssertEqual(uri, recipe!.recipesArray[0].uri)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetSearchShouldPostFailedCallbackIfNoData() {
        //Given
        TestURLProtocol.loadingHandler = { request in
            let response: HTTPURLResponse = FakeResponseData.responseOK
            let data: Data? = nil
            let error: Error? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.af.ephemeral
        configuration.protocolClasses = [TestURLProtocol.self] + (configuration.protocolClasses ?? [])
        let sessionManager = Alamofire.Session(configuration: configuration)
        let search = Search(session: sessionManager)
        let ingredient: [String] = ["Tomato"]
        
        let expectation = XCTestExpectation(description: "wait for queu change.")
        search.getRecipesResearch(for: ingredient) { success, recipe in
            
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetYieldShouldGiveTheServeWithAInt() {
        let configureRecipe = ConfigureRecipeDetails()
        let serve = configureRecipe.intToStringYield(10)
        
        XCTAssertEqual(serve, "Serve 10")
    }
    
    func testGetYieldShouldGiveThe0IfHaveNoYield() {
        let configureRecipe = ConfigureRecipeDetails()
        let serve = configureRecipe.intToStringYield(0)
        
        XCTAssertEqual(serve, "0")
    }
    
    func testShouldGiveHoursAndMinuteWhenGiven160() {
        let configureRecipe = ConfigureRecipeDetails()
        let hoursAndMinutes = configureRecipe.minutesToHoursAndMinutes(160)
        
        XCTAssertEqual(hoursAndMinutes, "2h 40m")
    }
    
    func testShouldGiveMinuteWhenGiven16() {
        let configureRecipe = ConfigureRecipeDetails()
        let hoursAndMinutes = configureRecipe.minutesToHoursAndMinutes(16)
        
        XCTAssertEqual(hoursAndMinutes, "16m")
    }
    
    func testShouldGiveNoMinutesAndHoursWhenGiven0() {
        let configureRecipe = ConfigureRecipeDetails()
        let hoursAndMinutes = configureRecipe.minutesToHoursAndMinutes(0)
        
        XCTAssertEqual(hoursAndMinutes, "")
    }
    
    func testManageFavoriteWithAddingKnowIfAlsoFavoriteAndRemoveIt() {
        let recipeDetails = RecipeDetails()
        let recipe = Recipe(cookIngredientsLines: ["Tomato"], ingredients: "Tomato", label: "A Tomato", cookImage: "cookBaseImage", totalTime: "2m", cookUrl: "tomatoDotCom", cookUri: "TomatoURI", yield: "TomatoYield")
        
        recipeDetails.configureRecipeDetails(whichSegue: true, recipeSearch: recipe, recipeFavorite: nil)
        XCTAssertEqual(recipeDetails.uri, recipe.uri)
        
        recipeDetails.addFavorite()
        XCTAssertTrue(recipeDetails.isAlreadyFavorite())
        
        recipeDetails.remove()
        XCTAssertFalse(recipeDetails.isAlreadyFavorite())
    }
}
