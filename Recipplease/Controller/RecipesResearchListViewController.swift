//
//  RecipesViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 20/01/2022.
//

import UIKit

class RecipesResearchListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var recipesView: UITableView!
    
    var recipes: Recipes? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes!.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: recipes!.label[indexPath.row], time: recipes!.totalTime[indexPath.row], image: recipes!.image[indexPath.row], ingredients: recipes!.ingredients[indexPath.row], serve: recipes!.yield[indexPath.row])
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToRecipe" {
            guard let indexPath = recipesView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! RecipesDetailsViewController
            desVC.whichSegue = true
            desVC.recipesSearch = recipes
            desVC.recipeIndex = indexPath
        }
    }
}
