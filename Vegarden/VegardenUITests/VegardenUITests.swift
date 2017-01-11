//
//  VegardenUITests.swift
//  VegardenUITests
//
//  Created by Sarah Cleland on 11/01/17.
//  Copyright © 2017 Juan Nuvreni. All rights reserved.
//

import XCTest

class VegardenUITests: XCTestCase {

    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
    
    func testExample() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        
        snapshot("03")
        
        tablesQuery.staticTexts["Total Rows : 4"].tap()
        
        snapshot("04")
        
        app.buttons["Confirm"].tap()
        
        snapshot("05")
        
        app.alerts["Information"].buttons["OK"].tap()
        
        tablesQuery.cells.containing(.staticText, identifier:"Dsfasdf from").children(matching: .button).matching(identifier: "Edit Rows").element(boundBy: 1).tap()
        
        snapshot("04")
        
        app.buttons["Close"].tap()
        tablesQuery.cells.tables.children(matching: .cell).element(boundBy: 0).swipeRight()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        snapshot("05")
        
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.swipeUp()
        
        snapshot("06")
        
        collectionViewsQuery.tables.staticTexts["Carrot"].swipeDown()
        
        snapshot("07")
        
        
        XCUIApplication().collectionViews.images["rocket"].swipeUp()
        XCUIApplication().collectionViews.tables.buttons["Plant"].tap()
        
        snapshot("08")
        
        let collectionViewsQuery2 = XCUIApplication().collectionViews
        collectionViewsQuery2.images["carrot"].tap()
        
        snapshot("09")
        
        collectionViewsQuery2.tables.buttons["Plant"].tap()
        
        snapshot("11")
        
        XCUIApplication().buttons["Water"].tap()
        
        
        
    }
    
}

extension XCUIElement {
    
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector.init(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}
