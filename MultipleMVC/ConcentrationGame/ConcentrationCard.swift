//
//  Card.swift
//  MultipleMVC
//
//  Created by Pawel Misiak on 11/20/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import Foundation

struct ConcentrationCard {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0;
    
    private static func getUniqueIdentifier() -> Int {  // makes it class method and not an instance method
        identifierFactory += 1                  // it will only work with static variables
        return ConcentrationCard.identifierFactory
    }
    init() {
        self.identifier = ConcentrationCard.getUniqueIdentifier() // since init is not static we need to specify the class
    }
}

