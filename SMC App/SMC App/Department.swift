//
//  Department.swift
//  
//
//  Created by Harrison Balogh on 5/26/15.
//
//

import Foundation
import CoreData

class Department: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var courses: NSSet
    
    class func departmentInManagedObjectContext(moc: NSManagedObjectContext, title: String) -> Department {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Department", inManagedObjectContext: moc) as! Department
        newItem.title = title
        
        return newItem
    }

}
