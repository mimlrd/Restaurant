//
//  RestaurantUITests.swift
//  RestaurantUITests
//
//  Created by Mike Milord on 25/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import XCTest

class RestaurantUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        app.navigationBars["La Fourchette"].buttons["filter"].tap()
        XCTAssertTrue(app.buttons["Cuisine"].exists, "Label Cuisine exits")
        XCTAssertTrue(app.buttons["Prix"].exists, "Label Prix Exist")
        XCTAssertTrue(app.buttons["Distance"].exists, "Label Distance Exist")
        XCTAssertTrue(app.staticTexts["Faites votre choix"].exists, "Label Faites vos choix Exist")
        //XCTAssertTrue(app.buttons["Reserver"].exists, "Label Reserver Exist")
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
}
