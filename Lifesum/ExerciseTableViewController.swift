//
//  ExerciseTableViewController.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit
import CoreData

class ExerciseTableViewController: UITableViewController {

    private var exercises: Array<Exercise> = [] //all exercises
    private var currentFetchOffset: Int = 0
    private var fetchLimit: Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMoreData()
    }
    
    private func loadMoreData(){
        // Fetch request
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        // fetch exercises by page with limit of 20
        let fetchRequest = NSFetchRequest(entityName: "Exercise")
        fetchRequest.fetchLimit = 20
        fetchRequest.fetchOffset = currentFetchOffset * fetchLimit
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do{
            let result = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Exercise]
            if result.count > 0 {
                exercises += result
                currentFetchOffset++
            }
            
            // Reload the table view but need to scroll it back to the previous position
            self.tableView.reloadData()
            
            
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
        return exercises.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("exerciseCell", forIndexPath: indexPath) as! ExerciseTableViewCell

        let exercise:Exercise = exercises[indexPath.row]
        
        // Configure the cell...
        cell.titleLabel.text = exercise.title
        
        let totalCal:Double = exercise.calories * 30
        cell.caloriesLabel.text = String(format: "%.0f calories", totalCal)
        
        cell.timeLabel.text = "30 min"

        return cell
    }

    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        // Check if the will display indexPath is the last. If last make request for next page feed
        if indexPath.row == self.exercises.count - 1 {
            loadMoreData()
        }

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
