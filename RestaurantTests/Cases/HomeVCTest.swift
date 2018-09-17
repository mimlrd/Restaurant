//
//  HomeVCTest.swift
//  RestaurantTests
//
//  Created by Mike Milord on 24/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import XCTest
@testable import Restaurant

class HomeVCTest: XCTestCase {
    
    var home: HomeVC!
    
    override func setUp() {
        super.setUp()
        home = HomeVC()
        
    }
    
    func testNumberOfResto(){
        let nbrOfResto = home.restos.count
        
        XCTAssertEqual(nbrOfResto, 5, "Testing the number of restos")
    
    }

    
}
