//
//  JIP4iDUITests.swift
//  JIP4iDUITests
//
//  Created by Erik Waterham on 06/01/2020.
//  Copyright © 2020 Erik Waterham. All rights reserved.
//

import XCTest

private class JIP4iDUITests: XCTestCase { // swiftlint:disable:this private_unit_test

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
