//
//  Personality.swift
//  
//
//  Created by Harrison Balogh on 5/26/15.
//
//

import Foundation
import CoreData

class Personality: Professor {

    @NSManaged var clarity: NSNumber
    @NSManaged var helpfulness: NSNumber
    @NSManaged var hygiene: NSNumber
    @NSManaged var punctuality: NSNumber
    @NSManaged var professor: Professor

}
