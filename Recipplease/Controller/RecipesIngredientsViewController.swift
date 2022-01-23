//
//  RecipesIngredientsViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 22/01/2022.
//

import UIKit

class RecipesIngredientsViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var cookIcon: UIImageView!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var addFavoriteButton: UIBarButtonItem!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var ingredientsLines: UITextView!
    
    let recipeDetails = RecipeManageDetails()
    var recipeIndex: Int?
    
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
        recipeDetails.configureRecipeDetails(recipeIndex!)
        haveDirections()
        alreadyFavorite()
        cookTime()
    }

    @IBAction func getDirections(_ sender: Any) {
        recipeDetails.openDirectionsURL()
    }
    
    @IBAction func addFavorite(_ sender: Any) {
        if recipeDetails.isAlreadyFavorite() {
            addFavoriteButton.tintColor = .systemBlue
            recipeDetails.remove()
        } else {
            addFavoriteButton.tintColor = .yellow
            recipeDetails.addFavorite()
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

extension RecipesIngredientsViewController: RecipesDetails {
    func openDirectionsURL(directions: URL) {
            UIApplication.shared.open(URL(string: "\(directions)")!)
    }
    
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String) {
        recipeImage.image = image
      recipeTime.text = time
        recipeTitle.text = title
       ingredientsLines.text = ingredients
    }
}
