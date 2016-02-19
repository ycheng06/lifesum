//
//  FoodTableViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    private var categories: Array<Category> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Fetch request
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // fetch exercises by page with limit of 20
        let fetchRequest = NSFetchRequest(entityName: "Category")
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "headCategoryId", ascending: true),
            NSSortDescriptor(key: "category", ascending: true)
        ]
        
        fetchRequest.predicate = NSPredicate(format: "headCategoryId != 15")
        
        do{
            categories = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Category]
            
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
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
        return self.categories.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell
        
        // Configure the cell...
        cell.categoryLabel.text = categories[indexPath.row].category
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showFood" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! FoodTableViewController
                destinationController.category = self.categories[indexPath.row]
            }
        }
    }
    
}
