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
    
    func testExample() {
    
        
        let app = XCUIApplication()
        
        testMyGardenViewScreen(app: app)
        
        testDatabase(app: app)
        
        testPlanting(app: app)
        
     //   testLifeCycle(app: app)
    }
    
    func testLifeCycle(app: XCUIApplication) {
        
        let cells = app.tables.cells
       
        cells.staticTexts["LifeCycle"].tap()
        
        app.otherElements["PopoverDismissRegion"].tap()
        
        app.tables.cells.staticTexts["Carrot"].tap()
        
        let celdas = app.tables.cells
        
        //let bttn = celdas.children(matching: .).matching(identifier: "actionMenu")
       // bttn.tap()
        
    }
    
    func testPlanting(app: XCUIApplication) {
        
        let cells = app.tables.cells
        cells.staticTexts["My Crops"].tap()
        
        app.otherElements["PopoverDismissRegion"].tap()
        
        app.collectionViews.images["carrot"].tap()
        app.collectionViews.tables.buttons["Plant"].tap()
    
        
       // let switch01 = app.tables.cells.staticTexts["switchAction"]
       // let sw0 = switches.element
        //switch01.tap()
        
        let txtField = app.textFields["notes"]
        UIPasteboard.general.string = "Planting some Carrots on a Sunny Day! =) "
       
        txtField.press(forDuration: 1.1)
        app.menuItems["Paste"].tap()
        
        snapshot("Planting01")
        
        
    }
    
    func testDatabase(app : XCUIApplication) {
        
        
        let cells = app.tables.cells
        cells.staticTexts["Database"].tap()
       
        app.otherElements["PopoverDismissRegion"].tap()
        
        snapshot("Database0")
        
        app.collectionViews.images["basil"].tap()
        
        snapshot("Basil")
        
        app.collectionViews.cells.tables.cells.staticTexts["Basil"].swipeDown()
        
        app.collectionViews.images["cabbage"].tap()
        
        snapshot("Cabbage")
        
        app.collectionViews.cells.tables.cells.staticTexts["Cabbage"].swipeDown()
        
        
        
    }
    
    func testMyGardenViewScreen(app : XCUIApplication) {
       
        app.otherElements["PopoverDismissRegion"].tap()
        
        let tablesQuery = app.tables
        
        snapshot("MyGardenView01")
        
        tablesQuery.staticTexts["Brassicas"].tap()
        
        snapshot("MyGardenView01_EditPatch")
        
        app.buttons["Close"].tap()
        
        
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
