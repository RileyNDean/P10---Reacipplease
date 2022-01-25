//
//  FavoritesDetailsViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 24/01/2022.
//

import UIKit

class FavoritesDetailsViewController: UIViewController {

    @IBOutlet weak var isFavorite: UIBarButtonItem!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var cookTime: UILabel!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var cookIcon: UIImageView!
    @IBOutlet weak var ingredientsLines: UITextView!
    
    var recipesFavorite: RecipesList?
    var recipeIndex: Int?
    var recipeDetails = FavoriteDetail()
    
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
        recipeDetails.configureFavorite(recipe: recipesFavorite!)
        cookTimer()
    }
    

    @IBAction func suppFavorite(_ sender: Any) {
        recipeDetails.remove()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func getDirection(_ sender: Any) {
        recipeDetails.openDirectionsURL()
    }
    
    func cookTimer() {
        if cookTime.text == "" {
            cookTime.isHidden = true
            cookIcon.isHidden = true
        }
    }
    
    func haveDirections() {
        if !recipeDetails.havedirections {
            directionsButton.isHidden = true
        }
    }
}

extension FavoritesDetailsViewController: RecipesDetails {
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String) {
        imageRecipe.image = image
        cookTime.text = time
        recipeTitle.text = title
        ingredientsLines.text = ingredients
    }
    
    func openDirectionsURL(directions: URL) {
        UIApplication.shared.open(URL(string: "\(directions)")!)
    }
}
