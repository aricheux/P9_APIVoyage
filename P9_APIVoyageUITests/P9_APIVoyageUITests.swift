//
//  P9_APIVoyageUITests.swift
//  P9_APIVoyageUITests
//
//  Created by RICHEUX Antoine on 16/01/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import XCTest

class P9_APIVoyageUITests: XCTestCase {
        
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        let app = XCUIApplication()
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        let element = element2.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textView = element.children(matching: .textView).element
        // Tab bar money rate
        textView.tap()
        textView.typeText("10.25")
        app.buttons["Convert"].tap()
        app.keys["Delete"].press(forDuration: 1.0)
        element.tap()
        // Tab bar translation
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Translate"].tap()
        let textView2 = element.children(matching: .textView).element(boundBy: 0)
        textView2.tap()
        textView2.typeText("Bonjour")
        let translateButton = element2.buttons["Translate"]
        translateButton.tap()
        let deleteKey = app.keys["delete"]
        deleteKey.press(forDuration: 1.5)
        element.children(matching: .textView).element(boundBy: 1).tap()
        translateButton.tap()
        app.alerts.buttons["Ok"].tap()
        textView2.tap()
        textView2.typeText("Hello")
        app.buttons["reverse"].tap()
        translateButton.tap()
        sleep(1)
        deleteKey.press(forDuration: 1.5)
        textView2.typeText("Buenos dias")
        translateButton.tap()
        sleep(1)
        let switch2 = app.switches["0"]
        switch2.tap()
        translateButton.tap()
        deleteKey.press(forDuration: 1.5)
        app.buttons["copy"].tap()
        element.tap()
        let switch3 = app.switches["1"]
        switch3.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element(boundBy: 1).tap()
                sleep(2)
        // Tab bar weather
        tabBarsQuery.buttons["Weather"].tap()
        sleep(5)
        
        
    }
    
}
