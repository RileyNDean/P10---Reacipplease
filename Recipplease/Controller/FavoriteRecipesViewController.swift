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
    
    private let favoriteRepository = FavoriteRecipes()
    private var recipesFavorite: [RecipesList] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRecipes()
        favoriteTableView.reloadData()
    }
    
    private func getRecipes() {
        favoriteRepository.getRecipes { [weak self] recipes in
            self?.recipesFavorite = recipes
            self?.favoriteTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesFavorite.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? RecipesFavoriteTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesFavorite[indexPath.row]
        cell.configure(name: recipe.title!, time: recipe.time!, image: recipe.image!, ingredients: recipe.ingredients!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoriteRecipes" {
            guard let indexPath = favoriteTableView.indexPathForSelectedRow?.row else {return}
            let desVC = segue.destination as! FavoritesDetailsViewController
            desVC.recipesFavorite = recipesFavorite[indexPath]
        }
    }
}
