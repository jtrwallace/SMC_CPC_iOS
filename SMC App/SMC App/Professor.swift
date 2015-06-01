//
//  Professor.swift
//  
//
//  Created by Harrison Balogh on 5/26/15.
//
//

import Foundation
import CoreData

class Professor: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var courses: NSSet
    @NSManaged var personality: Personality
    
    class func professorInManagedObjectContext(moc: NSManagedObjectContext, name: String) -> Professor {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Professor", inManagedObjectContext: moc) as! Professor
        newItem.name = name
        
        return newItem
    }

}
