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
    var recipes: Recipe?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        recipeDetails.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        recipeDetails.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alreadyFavorite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetails.configureRecipeDetails(recipeSearch: recipes)
        haveDirections()
        cookTime()
        haveServe()
    }

    //MARK: go to the navigator 
    @IBAction func getDirections(_ sender: Any) {
        UIApplication.shared.open(URL(string: recipes!.url)!, options: [:], completionHandler: nil)
    }
    
    //MARK: adding a recipe to the favorite
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
    
    //MARK: hide serve if have no serve
    func haveServe() {
        if serveLabel.text == "0" {
            serveLabel.isHidden = true
            serveIcon.isHidden = true
        }
    }
    
    //MARK: hide cooktime if have no time
    func cookTime() {
        if recipeTime.text == "" {
            recipeTime.isHidden = true
            cookIcon.isHidden = true
        }
    }

    //MARK: Know if the recipe is already in favorite for the search
    func alreadyFavorite() {
        if recipeDetails.isAlreadyFavorite() {
            addFavoriteButton.tintColor = .yellow
        }
    }
    
    //MARK: Hide get direction button if have no directions
    func haveDirections() {
        if !recipeDetails.havedirections {
            directionsButton.isHidden = true
        }
    }
}

extension RecipesDetailsViewController: RecipesDetailsDelegate {
    func configureRecipeDetails(image: String, title: String, time: String, ingredients: String, serve: String) {
        recipeImage.downloaded(from: image)
      recipeTime.text = time
        recipeTitle.text = title
       ingredientsLines.text = ingredients
        serveLabel.text = serve
    }
}
