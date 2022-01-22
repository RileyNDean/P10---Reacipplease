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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchButton: UIButton!
    
    let manageIngredients = ManageIngredient()
    let errorManage = ErrorController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        manageIngredients.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        manageIngredients.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addIngredient(_ sender: Any) {
        manageIngredients.addingIngredient(ingredient.text)
        ingredient.text = ""
    }
    
    func getResearch() {
        toggleActivityIndicator(shown: true)
        
        Search.shared.getResearch { success, research in
            self.toggleActivityIndicator(shown: false)
            if success {
                if Recipes.responseIsEmpty {
                    self.errorManage.presentAlertData(controller: self)
                } else {
                    self.performSegue(withIdentifier: "RecipesTable", sender: nil)
                }
            } else {
                self.errorManage.presentAlertNetwork(controller: self)
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        searchButton.isHidden = shown
    }
    
    @IBAction func dissmissKeyboard(_ sender: Any) {
        ingredient.resignFirstResponder()
    }
    
    @IBAction func clearIngredientList(_ sender: UIButton) {
        manageIngredients.cleanIngredients()
    }
    
    @IBAction func searchRecip(_ sender: UIButton) {
        if Search.ingredientsListIsEmpty {
            self.errorManage.presentAlertIngredientListEmpty(controller: self)
        } else {
            getResearch()
        }
    }
}

extension SearchViewController: AddIngredientsDelegate {
    func cleanIngredientsDelegate() {
        ingredientsTextView.text = ""
    }
    
    func addingIngredientsDelegate(ingredients: String) {
        ingredientsTextView.text = ingredients
    }
}
