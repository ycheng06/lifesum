//
//  Exercise.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import CoreData

class Exercise:NSManagedObject{
    //user related info
    @NSManaged var title:String
    @NSManaged var calories:Double
    
    //hidden info
    @NSManaged var addedByUser:Bool
    @NSManaged var custom:Bool
    @NSManaged var removed:Bool
    @NSManaged var downloaded:Bool
    @NSManaged var hidden:Bool
    @NSManaged var lastUpdated:String
    @NSManaged var oid:String
    @NSManaged var photoVersion:String

    
}