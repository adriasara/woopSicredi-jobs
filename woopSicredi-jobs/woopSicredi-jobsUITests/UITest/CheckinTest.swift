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
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"R$ 29,99")/*[[".cells.containing(.staticText, identifier:\"Feira de adoção de animais na Redenção\")",".cells.containing(.staticText, identifier:\"R$ 29,99\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["20-08-2018 01:00 PM"].tap()
        
        let app2 = XCUIApplication()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Check-in"]/*[[".buttons[\"Check-in\"].staticTexts[\"Check-in\"]",".staticTexts[\"Check-in\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let typeEmail = app2.alerts["Bem-vindo"].scrollViews.otherElements.collectionViews.textFields["Preencha seu e-mail"]
        XCTAssertTrue(typeEmail.exists)
        
        typeEmail.tap()
        typeEmail.typeText(email)
        
        app.alerts["Bem-vindo"].scrollViews.otherElements.buttons["Check-in"].tap()
        app.alerts["Sucesso"].scrollViews.otherElements.buttons["Ok"].tap()
    }
}
