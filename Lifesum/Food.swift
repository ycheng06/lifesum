//
//  Food.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import CoreData

class Food:NSManagedObject{
    //user related info
    @NSManaged var title:String
    @NSManaged var calories:Double
    @NSManaged var carbohydrates:Double
    @NSManaged var fat:Double
    @NSManaged var fiber:Double
    @NSManaged var cholesterol:Double
    @NSManaged var potassium:Double
    @NSManaged var protein:Double
    @NSManaged var saturatedFat:Double
    @NSManaged var unSaturatedFat:Double
    @NSManaged var sodium:Double
    @NSManaged var sugar:Double
    @NSManaged var pcstext:String
    @NSManaged var showMeasurement:String
    
    //hidden info
    @NSManaged var addedByUser:Bool
    @NSManaged var typeOfMeasurement:String
    @NSManaged var sourcdId:Int
    @NSManaged var servingCategory:Int
    @NSManaged var gramsPerServing:Double
    @NSManaged var language:String
    @NSManaged var lastUpdated:String
    @NSManaged var ocategoryId:Int
    @NSManaged var oid:Int
    @NSManaged var pcsingram:String
    @NSManaged var categoryId:Int
    @NSManaged var downloaded:Bool
    
    //relationship
    @NSManaged var category:Set<Category>

}
