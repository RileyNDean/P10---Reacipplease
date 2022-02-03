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
    @IBOutlet weak var serveIcon: UIImageView!
    @IBOutlet weak var serveLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cookTimeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(name: String, time: String, image: String, ingredients: String, serve: String){
        printTime(time: time)
        recipeNameLabel.text = name
        recipeImage.image = getImage(image)
        ingredientsLabel.text = ingredients
        printServe(serve: serve)
        
    }
    
    func configure(listedReciped: ListedRecipe)
    {
        
    }
    
    private func printServe(serve: String) {
        if serve == "0" {
            serveIcon.isHidden = true
            serveLabel.isHidden = true
        } else {
            serveLabel.text = serve
        }
    }
    
    private func printTime(time: String) {
        if time == "" {
            timeLabel.isHidden = true
            cookTimeImage.isHidden = true
        } else {
            timeLabel.text = time
        }
    }
    
    private func getImage(_ imageURLString: String) -> UIImage {
        let imageURL = URL(string: imageURLString)
         let imageData = try! Data(contentsOf: imageURL!)
        if imageData.isEmpty {
            return UIImage(named: "cookBaseImage")!
        } else {
        let image = UIImage(data: imageData)
            return image!
        }
    }
}
