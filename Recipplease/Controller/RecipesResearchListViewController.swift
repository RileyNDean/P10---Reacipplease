//
//  RecipesViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 20/01/2022.
//

import UIKit

class RecipesResearchListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var recipesView: UITableView!
    
    var recipes: [Recipe] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipesView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: recipes[indexPath.row].label,
                       time: recipes[indexPath.row].totalTime,
                       image: recipes[indexPath.row].cookImage,
                       ingredients: recipes[indexPath.row].ingredient,
                       serve: recipes[indexPath.row].yield)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToRecipe" {
            guard let indexPath = recipesView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! RecipesDetailsViewController
            desVC.whichSegue = true
            desVC.recipesSearch = recipes[indexPath]
        }
    }
}
