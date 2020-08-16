//
//  CheckinTest.swift
//  woopSicredi-jobsUITests
//
//  Created by Ádria Cardoso on 15/08/20.
//  Copyright © 2020 Ádria Cardoso. All rights reserved.
//

import Foundation
import XCTest

class CheckingTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidCheckinWithoutName() {
        
        let email = "adriacardoso_@hotmail.com"
        
        let app = XCUIApplication()
        app.launch()
        
        let tableView = app.tables["eventListTbView"]
        tableView.cells["my_cell"].staticTexts["titleID"].tap()
        
        let app2 = XCUIApplication()
        app2.buttons["checkInButton"].tap()
        
        let typeEmail = app.textFields["enterEmailTxtField"]
        XCTAssertTrue(typeEmail.exists)
        
        typeEmail.tap()
        typeEmail.typeText(email)
        
        app.buttons["checkInButtonAlert"].tap()
        app.buttons["okButtonAlert"].tap()
    }
}
