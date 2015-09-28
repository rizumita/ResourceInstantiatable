//
//  StoryboardInstantiatorTests.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/28.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import XCTest
@testable import ResourceInstantiatable

class StoryboardInstantiatorTests: XCTestCase {
    
    class StoryboardsManager {
        static let testViewController = StoryboardInstantiator<TestViewController>(name: "Test", bundle: NSBundle(forClass: StoryboardInstantiatorTests.self))
        static let secondaryViewController = StoryboardInstantiator<TestViewController>(name: "Test", bundle: NSBundle(forClass: StoryboardInstantiatorTests.self), identifier: "Secondary")
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
        XCTAssertEqual(StoryboardsManager.testViewController.instantiate().message, "InitialViewController")
        XCTAssertEqual(StoryboardsManager.secondaryViewController.instantiate().message, "SecondaryViewController")
    }
    
    func testInstantiateWithConfigure() {
        func configure(controller: TestViewController) {
            controller.message = "Configured"
        }
        
        XCTAssertEqual(StoryboardsManager.testViewController.instantiate(configure).message, "Configured")
    }
    
}
