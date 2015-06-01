//
//  GradeDistribution.swift
//  
//
//  Created by Harrison Balogh on 5/26/15.
//
//

import Foundation
import CoreData

class GradeDistribution: NSManagedObject {

    @NSManaged var a: NSNumber
    @NSManaged var b: NSNumber
    @NSManaged var c: NSNumber
    @NSManaged var d: NSNumber
    @NSManaged var f: NSNumber
    @NSManaged var w: NSNumber
    @NSManaged var total: NSNumber
    @NSManaged var course: Course

}
