//
//  hearRingiOSWatchOSUITests.swift
//  hearRingiOSWatchOSUITests
//
//  Created by Hayley Owens on 2/14/22.
//

import XCTest

class hearRingiOSWatchOSUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }
    
    func testListenTab() throws {
        let listenbutton = app.buttons["Listen"]
        XCTAssert(listenbutton.exists)
        XCTAssertEqual(listenbutton.label, "Listen")
    }
    
    func testSpeakTab() throws {
        let ttsbutton = app.buttons["Speak"]
        XCTAssert(ttsbutton.exists)
        XCTAssertEqual(ttsbutton.label, "Speak")
    }
     
    func testAlarmTab() throws {
        let alarmbutton = app.buttons["Alarm"]
        XCTAssert(alarmbutton.exists)
        XCTAssertEqual(alarmbutton.label, "Alarm")
    }
    
    func testSettingsTab() throws {
        let settingsbutton = app.buttons["Settings"]
        XCTAssert(settingsbutton.exists)
        XCTAssertEqual(settingsbutton.label, "Settings")
    }
    
    func testAlarmView() throws {
        app.buttons["Alarm"].tap()
        let navBar = app.navigationBars.element
            XCTAssert(navBar.exists)
        let create = app.buttons["Create New Alarm"]
            XCTAssert(create.exists)
    }
    
    func testAlarmCreate() throws {
        app.buttons["Alarm"].tap()
        app.buttons["Create New Alarm"].tap()
        let saveButton = app.buttons["Save"]
            XCTAssert(saveButton.exists)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
