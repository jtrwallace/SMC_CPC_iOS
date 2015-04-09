//
//  Professor.swift
//  SMC App
//
//  Created by Harrison Balogh on 4/8/15.
//  Copyright (c) 2015 CPC iOS. All rights reserved.
//

import UIKit

class Professor: NSObject {
    
    var name: String!
    var rating: Int!
    
    init(name: String, rating: Int){
        super.init()
        
        self.name = name
        self.rating = rating
    }
}
