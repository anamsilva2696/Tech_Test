//
//  Tech_TestUITests.swift
//  Tech TestUITests
//
//  Created by Admin on 20.08.2024.
//

import XCTest

class Tech_TestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Example of uitesting, testing Picker
    func testSegmentedPickerSelection() throws {
            let app = XCUIApplication()
            app.launch()

            // Find the picker
            let picker = app.segmentedControls["populationDataPicker"]
            XCTAssertTrue(picker.exists)


    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
