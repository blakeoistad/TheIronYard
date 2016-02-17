//
//  Animals.swift
//  TVSections
//
//  Created by Blake Oistad on 11/11/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class Animals: NSObject {

    
    var animalCategory: String!
    var animalType: String!
    
    
    init(animalCategory: String, animalType: String) {            //easy one line animal creation initializer
        self.animalCategory = animalCategory
        self.animalType = animalType
    }
    
}
