//
//  ErrorController.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 21/01/2022.
//

import Foundation
import UIKit


class ErrorController {
    
    public func presentAlertIngredientListEmpty(controller: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: "Ingredients list is empty.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    public func presentAlertNetwork(controller: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: "Network error.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
    }
    
    public func presentAlertData(controller: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: "Problem with the ingredients.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.present(alertVC, animated: true, completion: nil)
    }
}
