//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by andre trosky on 6/12/2015.
//  Copyright © 2015 andre trosky. All rights reserved.
//

import UIKit
import XCTest


@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    // MARK: FoodTracker tests
    
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
    
        //Success case
        let potentialItem = Meal(name:"yadda", photo:nil, rating:5)
        XCTAssertNotNil(potentialItem)
        
        //failure case
        let noName = Meal(name:"", photo:nil, rating:5)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name:"yadda", photo:nil, rating:-1)
        XCTAssertNil(badRating)
    }
    
    
}
