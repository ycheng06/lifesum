//
//  FoodTableViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import CoreData

class FoodTableViewController: UITableViewController {

    var category:Category!
    private var food: Array<Food> = []
    private var localizedFood: Array<Food> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        food = Array(category.foods)
        
        // only display the localize food. doing us food for now
        localizedFood = food.filter{ (item) in item.language == "en_US"}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.localizedFood.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodTableViewCell

        // Configure the cell...
        let currentFood: Food = self.localizedFood[indexPath.row]
        cell.nameLabel.text = currentFood.title
        cell.caloriesLabel.text = String(format: " %.0f", currentFood.calories) + " cal "
        cell.servingLabel.text = "1 " + currentFood.pcstext
        cell.gramsLabel.text = String(format: " %.0f", currentFood.gramsPerServing) + " grams"

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showDetail"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! NutrientDetailTableViewController
                destinationController.food = self.localizedFood[indexPath.row]
            }
        }
        
    }
}
