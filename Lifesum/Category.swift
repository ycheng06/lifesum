//
//  Category.swift
//  Lifesum
//
//  Created by Jason Cheng on 2/17/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import Foundation
import CoreData

class Category:NSManagedObject{
    @NSManaged var category:String
    
    @NSManaged var headCategoryId:Int
    @NSManaged var servingsCategory:Int
    @NSManaged var oid:Int
    @NSManaged var photoVersion:String
    @NSManaged var lastUpdated:String
    @NSManaged var foods:Set<Food>
}
