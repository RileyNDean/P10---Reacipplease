//
//  SearchViewController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 18/01/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var ingredient: UITextView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addIngredient(_ sender: Any) {
    
    }
    
    func getResearch() {
        Search.shared.getResearch { success, research in
            if success {
                self.performSegue(withIdentifier: "RecipesTable", sender: nil)
            }
        }
    }
    
    @IBAction func clearIngredientList(_ sender: UIButton) {
    }
    
    @IBAction func searchRecip(_ sender: UIButton) {
        getResearch()
 
    }
    
}
