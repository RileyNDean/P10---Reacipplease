//
//  RecipesIngredientsViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import UIKit

class RecipesDetailsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var cookIcon: UIImageView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var addFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var serveIcon: UIImageView!
    @IBOutlet weak var serveLabel: UILabel!
    @IBOutlet weak var ingredientsLines: UITextView!
    
    let recipeDetails = RecipeDetails()
    var whichSegue = Bool()
    var recipesSearch: Recipes? = nil
    var recipesFavorite: RecipesList?
    var recipeIndex = Int()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        recipeDetails.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        recipeDetails.delegate = self
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetails.configureRecipeDetails(whichSegue: whichSegue, recipeIndex: recipeIndex, recipeSearch: recipesSearch, recipeFavorite: recipesFavorite)
        haveDirections()
        alreadyFavorite()
        cookTime()
        haveServe()
    }

    @IBAction func getDirections(_ sender: Any) {
        recipeDetails.openDirectionsURL()
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        if recipeDetails.isAlreadyFavorite() {
            addFavoriteButton.tintColor = .systemBlue
            recipeDetails.remove()
            navigationController?.popViewController(animated: true)
        } else {
            addFavoriteButton.tintColor = .yellow
            recipeDetails.addFavorite()
        }
        
    }
    
    func haveServe() {
        if serveLabel.text == "0" {
            serveLabel.isHidden = true
            serveIcon.isHidden = true
        }
    }
    
    func cookTime() {
        if recipeTime.text == "" {
            recipeTime.isHidden = true
            cookIcon.isHidden = true
        }
    }

    func alreadyFavorite() {
        if recipeDetails.isAlreadyFavorite() {
            addFavoriteButton.tintColor = .yellow
        }
    }
    
    func haveDirections() {
        if !recipeDetails.havedirections {
            directionsButton.isHidden = true
        }
    }
}

extension RecipesDetailsViewController: RecipesDetailsDelegate {
    
    func openDirectionsURL(directions: URL) {
            UIApplication.shared.open(URL(string: "\(directions)")!)
    }
    
    func configureRecipeDetails(image: String, title: String, time: String, ingredients: String, serve: String) {
        recipeImage.downloaded(from: image)
      recipeTime.text = time
        recipeTitle.text = title
       ingredientsLines.text = ingredients
        serveLabel.text = serve
    }
}
