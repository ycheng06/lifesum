//
//  NutrientDetailTableViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class NutrientDetailTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nutritionLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var cholesterolLabel: UILabel!
    @IBOutlet weak var sodiumLabel: UILabel!
    
    @IBOutlet weak var potassiumLabel: UILabel!
    
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fiberLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var saturatedFatLabel: UILabel!
    @IBOutlet weak var unSaturatedFatLabel: UILabel!
    
    var food:Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = food.title
        
        nutritionLabel.text = String(format: " %.0f", food.calories) + " cal " + "1 " + food.pcstext + String(format: " %.0f", food.gramsPerServing) + " grams"
        
        proteinLabel.text = String(food.protein)
        cholesterolLabel.text = String(food.cholesterol)
        sodiumLabel.text = String(food.sodium)
        potassiumLabel.text = String(food.potassium)
        
        carbsLabel.text = String(food.carbohydrates)
        fiberLabel.text = String(food.fiber)
        sugarLabel.text = String(food.sugar)
        
        fatLabel.text = String(food.fat)
        saturatedFatLabel.text = String(food.saturatedFat)
        unSaturatedFatLabel.text = String(food.unSaturatedFat)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
