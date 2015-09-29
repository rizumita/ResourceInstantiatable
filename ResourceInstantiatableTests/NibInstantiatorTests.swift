//
//  NibInstantiatorTests.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/29.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import XCTest
@testable import ResourceInstantiatable

class NibInstantiatorTests: XCTestCase {
    
    class NibsManager {
        static let testView = NibInstantiator<TestView>(name: "Test", bundle: NSBundle(forClass: NibInstantiatorTests.self))
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstantiate() {
        XCTAssertEqual(try? NibsManager.testView.instantiate().dynamicType.description(), "ResourceInstantiatableTests.TestView")
    }
    
    func testInstantiateWithConfigure() {
        func configure(inout view: TestView) {
            view.hidden = true
        }
        
        if let testView = try? NibsManager.testView.instantiate(configure) {
            XCTAssertTrue(testView.hidden)
        } else {
            XCTFail()
        }
    }
    
}
