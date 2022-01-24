//
//  RecipesViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 20/01/2022.
//

import UIKit

class RecipesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var recipesView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Recipes.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: Recipes.label[indexPath.row], time: Recipes.totalTime[indexPath.row], image: Recipes.image[indexPath.row], ingredients: Recipes.ingredients[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToRecipe" {
            guard let indexPath = recipesView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! RecipesIngredientsViewController
            desVC.recipeIndex = indexPath
        }
    }
}
