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
        let nib = UINib(nibName: "RecipeCell",bundle: nil)
        recipesView.register(nib, forCellReuseIdentifier: RecipeCell.identifier)
        recipesView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.identifier, for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: recipes[indexPath.row].label,
                       time: recipes[indexPath.row].totalTime,
                       image: recipes[indexPath.row].cookImage,
                       ingredients: recipes[indexPath.row].ingredient,
                       serve: recipes[indexPath.row].yield)
       
        return cell
    }
    
    //MARK: Segue configuration
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToRecipe" {
            guard let indexPath = recipesView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! RecipesDetailsViewController
            desVC.recipes = recipes[indexPath]
        }
    }
}

extension RecipesResearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == recipes.count else {
            self.performSegue(withIdentifier: "GoToRecipe", sender: nil)
            return
        }
    }
}
