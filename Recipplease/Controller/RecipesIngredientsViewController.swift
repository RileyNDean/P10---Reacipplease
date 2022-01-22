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
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var ingredientsLines: UITextView!
    
    let recipeDetails = RecipeIngredients()
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
        // Do any additional setup after loading the view.
    }

    @IBAction func getDirections(_ sender: Any) {
        
    }
}

extension RecipesIngredientsViewController: RecipesDetails {
    func configureRecipeDetails(image: UIImage, title: String, time: String, ingredients: String) {
        recipeImage.image = image
      recipeTime.text = time
        recipeTitle.text = title
       ingredientsLines.text = ingredients
    }
}
