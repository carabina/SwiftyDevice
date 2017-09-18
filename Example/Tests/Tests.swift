//
//  Tests.swift
//  SwiftyDevice_Tests
//
//  Created by Damien Legrand on 18/09/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyDevice

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSimulator() {
        
        XCTAssertEqual(SwiftyDevice.shared.deviceFamily, DeviceFamily.simulator)
        XCTAssertEqual(Device.currentDevice.family, DeviceFamily.simulator)
    }
    
    func testIphone() {
        
        let iphone = Device.device(with: "iPhone9,4")
        XCTAssertEqual(iphone.family, DeviceFamily.iPhone7Plus)
        XCTAssertNotNil(iphone.releaseDate)
    }
    
    func testInError() {
        
        let inError = Device.device(with: "foo_bar")
        XCTAssertEqual(inError.family, DeviceFamily.unknown)
        XCTAssertNil(inError.releaseDate)
    }
}
