//
//  LoadFromJSON.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/18/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

@objc public protocol LoadJSONToCoreDelegate{
    optional func dataLoaded(type: String) //type: data type done loading into core
}

// Load json asychncronously and insert into core data
class LoadFromJSON {
    static let sharedInstance = LoadFromJSON()
    
    func initialLoad(delegate: LoadJSONToCoreDelegate){
        // all the files to read from
        let staticFiles = ["exercisesStatic", "categoriesStatic", "foodStatic"]
        //        let staticFiles = ["exercisesStatic"]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let mainContext = appDelegate.managedObjectContext

        
        if isFirstTimeLaunch() {
            
            print("loading...")
            
            // create private queue to load json into core data
            let privateMOC = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
            privateMOC.parentContext = mainContext
            
            privateMOC.performBlock {
                
                // read from json
                for fileName:String in staticFiles {
                    if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json"){
                        do {
                            let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                            let jsonObj = JSON(data: data)
                            
                            // if nothing wrong with json. store into core data
                            if jsonObj != JSON.null {
                                
                                // get json as array
                                let list: Array<JSON> = jsonObj.arrayValue
                                var delegateType = ""
                                
                                // load data
                                if fileName == "exercisesStatic"{
                                    self.loadStaticExercises(list, privateMOC: privateMOC)
                                    delegateType = "exercise"
                                }
                                else if fileName == "categoriesStatic"{
                                    self.loadStaticCategories(list, privateMOC: privateMOC)
                                    delegateType = "category"
                                }
                                else {
                                    self.loadStaticFood(list, privateMOC: privateMOC)
                                    delegateType = "food"
                                }
                                
                                do {
                                    try privateMOC.save()
                                } catch {
                                    fatalError("Failure to save context: \(error)")
                                }
                                
                                appDelegate.saveContext()
                                delegate.dataLoaded?(delegateType)
                                
                            } else { print("json file not valid. please check")}
                        } catch let error as NSError { print(error.localizedDescription)}
                    } else { print("invalid path name")}
                }
                
                // save all the core data entities that were created
//                appDelegate.saveContext()

            }
        }
    }
    
    // check if app launching for first time
    private func isFirstTimeLaunch()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let launchedOnce:Bool = defaults.boolForKey("appAlreadyLaunchedOnce")
        
        if !launchedOnce {
            defaults.setBool(true, forKey: "appAlreadyLaunchedOnce")
            return true
        } else {
            return false
        }
    }

    
    // connect entity with json
    private func loadStaticExercises(list:Array<JSON>, privateMOC: NSManagedObjectContext) {
        for data in list {
            let exercise: Dictionary<String, JSON> = data.dictionaryValue
            
            let exerciseEntity = NSEntityDescription.insertNewObjectForEntityForName("Exercise", inManagedObjectContext: privateMOC) as! Exercise
            
            exerciseEntity.title = exercise["title"]!.stringValue
            exerciseEntity.addedByUser = exercise["addedbyuser"]!.boolValue
            exerciseEntity.calories = exercise["calories"]!.doubleValue
            exerciseEntity.custom = exercise["custom"]!.boolValue
            exerciseEntity.removed = exercise["deleted"]!.boolValue
            exerciseEntity.downloaded = exercise["downloaded"]!.boolValue
            exerciseEntity.hidden = exercise["hidden"]!.boolValue
            exerciseEntity.lastUpdated = exercise["lastupdated"]!.stringValue
            exerciseEntity.oid = exercise["oid"]!.stringValue
            exerciseEntity.photoVersion = exercise["photo_version"]!.stringValue
        }
    }
    
    // connect entity with json
    private func loadStaticCategories(list:Array<JSON>, privateMOC: NSManagedObjectContext){
        for data in list {
            let category: Dictionary<String, JSON> = data.dictionaryValue
            
            let categoryEntity = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: privateMOC) as! Category
            
            categoryEntity.category = category["category"]!.stringValue
            categoryEntity.headCategoryId = category["headcategoryid"]!.intValue
            categoryEntity.servingsCategory = category["servingscategory"]!.intValue
            categoryEntity.oid = category["oid"]!.intValue
            categoryEntity.photoVersion = category["photo_version"]!.stringValue
            categoryEntity.lastUpdated = category["lastupdated"]!.stringValue
        }
    }
    
    // connect entity with json
    private func loadStaticFood(list:Array<JSON>, privateMOC: NSManagedObjectContext){
        for data in list {
            let food: Dictionary<String, JSON> = data.dictionaryValue
            let foodEntity = NSEntityDescription.insertNewObjectForEntityForName("Food", inManagedObjectContext: privateMOC) as! Food
            
            let servingCategory = food["servingcategory"]!.intValue
            let fetchRequest = NSFetchRequest(entityName: "Category")
            fetchRequest.predicate = NSPredicate(format: "servingsCategory == %d", servingCategory)
            
            // set relationship Many to Many (category & food)
            do{
                let categories = try privateMOC.executeFetchRequest(fetchRequest) as! [Category]
                if categories.count > 0{
                    for category in categories {
                        foodEntity.category.insert(category)
                    }
                    
                }
                
            } catch {
                print("can't get required category")
            }
            
            foodEntity.title = food["title"]!.stringValue
            foodEntity.calories = food["calories"]!.doubleValue
            foodEntity.carbohydrates = food["carbohydrates"]!.doubleValue
            foodEntity.fat = food["fat"]!.doubleValue
            foodEntity.fiber = food["fiber"]!.doubleValue
            foodEntity.cholesterol = food["cholesterol"]!.doubleValue
            foodEntity.potassium = food["potassium"]!.doubleValue
            foodEntity.protein = food["protein"]!.doubleValue
            foodEntity.saturatedFat = food["saturatedfat"]!.doubleValue
            foodEntity.unSaturatedFat = food["unsaturatedfat"]!.doubleValue
            foodEntity.sodium = food["sodium"]!.doubleValue
            foodEntity.sugar = food["sugar"]!.doubleValue
            foodEntity.pcstext = food["pcstext"]!.stringValue
            foodEntity.showMeasurement = food["showmeasurement"]!.stringValue
            
            foodEntity.addedByUser = food["addedbyuser"]!.boolValue
            foodEntity.typeOfMeasurement = food["typeofmeasurement"]!.stringValue
            foodEntity.sourcdId = food["source_id"]!.intValue
            foodEntity.servingCategory = food["servingcategory"]!.intValue
            foodEntity.gramsPerServing = food["gramsperserving"]!.doubleValue
            foodEntity.language = food["language"]!.stringValue
            foodEntity.lastUpdated = food["lastupdated"]!.stringValue
            foodEntity.ocategoryId = food["ocategoryid"]!.intValue
            foodEntity.oid = food["oid"]!.intValue
            foodEntity.pcsingram = food["pcsingram"]!.stringValue
            foodEntity.categoryId = food["categoryid"]!.intValue
            foodEntity.downloaded = food["downloaded"]!.boolValue
            
        }
    }

}