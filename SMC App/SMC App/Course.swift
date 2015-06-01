//
//  Course.swift
//  
//
//  Created by Harrison Balogh on 5/26/15.
//
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var id: NSNumber
    @NSManaged var semester: String
    @NSManaged var year: NSNumber
    @NSManaged var section: NSNumber
    @NSManaged var department: Department
    @NSManaged var professor: Professor
    @NSManaged var grade_distribution: NSManagedObject

    class func courseInManagedObjectContext(moc: NSManagedObjectContext, title: String, department: Department, professor: Professor) -> Course {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: moc) as! Course
        newItem.title = title
        newItem.department = department
        newItem.professor = professor
        
        return newItem
    }
    
}
