//
//  FavoriteRecipesViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 24/01/2022.
//

import UIKit
import CoreData

class FavoriteRecipesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var instructionText: UITextView!
    @IBOutlet weak var tableFavorite: UITableView!
    
    private let favoriteRepository = FavoriteRecipes()
    private var recipesFavorite: [RecipesList] = []
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nib = UINib(nibName: "RecipeCell",bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        getRecipes()
        favoriteTableView.reloadData()
    }
    
    //MARK: Get the recipes in the recipesList
    private func getRecipes() {
        favoriteRepository.getRecipes { [weak self] recipes in
            self?.recipesFavorite = recipes
            if recipes.count != 0 {
                self?.tableFavorite.isHidden = false
                self?.favoriteTableView.reloadData()
            } else {
                self?.tableFavorite.isHidden = true
            }
        }
    }
    
    //MARK: UITableFavoriteTableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesFavorite.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesFavorite[indexPath.row]
         cell.configure(name: recipe.title!, time: recipe.time!, image: recipe.image!, ingredients: recipe.ingredients!, serve: recipe.yield!)
         
        return cell
    }
    
    //MARK: sEGUE CONFIGURATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoriteRecipes" {
            guard let indexPath = favoriteTableView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! RecipesDetailsViewController
            let recipeConfig = Recipes()
            let recipe = recipeConfig.createRecipeForCoreDataCell(with: recipesFavorite[indexPath])
            desVC.recipes = recipe
        }
    }
}

extension FavoriteRecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == recipesFavorite.count else {
            self.performSegue(withIdentifier: "FavoriteRecipes", sender: nil)
            return
        }
    }
}
