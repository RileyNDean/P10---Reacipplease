//
//  RecipesTableViewCell.swift
//  Recipplease
//
//  Created by Dhayan Bourguignon on 20/01/2022.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cookTimeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }

    private func addShadow() {
        recipeImage.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        recipeImage.layer.shadowRadius = 2.0
        recipeImage.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        recipeImage.layer.shadowOpacity = 2.0
    }
    
    func configure(name: String, time: String, image: UIImage, ingredients: String){
        printTime(time: time)
        recipeNameLabel.text = name
        recipeImage.image = image
        ingredientsLabel.text = ingredients
    }
    
    private func printTime(time: String) {
        if time == "" {
            timeLabel.isHidden = true
            cookTimeImage.isHidden = true
        } else {
            timeLabel.text = String(time)
        }
    }
}
