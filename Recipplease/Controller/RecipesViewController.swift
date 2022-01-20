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
        return RecipeSearch.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: RecipeSearch.label[indexPath.row], time: RecipeSearch.totalTime[indexPath.row], image: RecipeSearch.image[indexPath.row], ingredients: RecipeSearch.ingredients[indexPath.row])
        
        return cell
    }
    

 
}
