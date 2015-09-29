//
//  FileInstantiatorTests.swift
//  ResourceInstantiatable
//
//  Created by 和泉田 領一 on 2015/09/29.
//  Copyright © 2015年 CAPH. All rights reserved.
//

import XCTest
@testable import ResourceInstantiatable

class FileInstantiatorTests: XCTestCase {
    
    struct FilesManager {
        static let stringsPList = FileInstantiator<[String]>(name: "Strings", type: "plist", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { NSArray(contentsOfFile: $0) as? [String] }
        static let dictPList = FileInstantiator<[String : String]>(name: "Dict", type: "plist", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { NSDictionary(contentsOfFile: $0) as? [String : String] }
        static let textFile = FileInstantiator<String>(name: "Text", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { try String(contentsOfFile: $0) }
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
        if let strings = try? FilesManager.stringsPList.instantiate() {
            XCTAssertEqual(strings.count, 1)
            XCTAssertEqual(strings.first!, "first")
        } else {
            XCTFail()
        }
        
        if let dict = try? FilesManager.dictPList.instantiate() {
            XCTAssertEqual(dict.count, 1)
            XCTAssertEqual(dict["name"], "test")
        } else {
            XCTFail()
        }
        
        if let text = try? FilesManager.textFile.instantiate() {
            XCTAssertEqual(text, "This is a file for testing.")
        } else {
            XCTFail()
        }
    }
    
    func testInstantiateWithConfigure() {
        func configure(inout strings: [String]) {
            strings.append("second")
        }
        
        if let strings = try? FilesManager.stringsPList.instantiate(configure) {
            XCTAssertEqual(strings.count, 2)
            XCTAssertEqual(strings.first!, "first")
            XCTAssertEqual(strings[1], "second")
        } else {
            XCTFail()
        }
        
        func configureDict(inout dict: [String : String]) {
            dict["title"] = "testtitle"
        }
        
        if let dict = try? FilesManager.dictPList.instantiate(configureDict) {
            XCTAssertEqual(dict.count, 2)
            XCTAssertEqual(dict["name"], "test")
            XCTAssertEqual(dict["title"], "testtitle")
        } else {
            XCTFail()
        }
        
        func configureText(inout text: String) {
            text.appendContentsOf("\n")
        }
        
        if let text = try? FilesManager.textFile.instantiate(configureText) {
            XCTAssertEqual(text, "This is a file for testing.\n")
        } else {
            XCTFail()
        }
    }
    
    func testFailInstantiating() {
        let textFile = FileInstantiator<String>(name: "Text", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { _ in throw NSError(domain: "testdomain", code: 1, userInfo: nil) }
        do {
            try textFile.instantiate()
            XCTFail()
        }
        catch let e as NSError {
            XCTAssertEqual(e.domain, "testdomain")
        }
    }
    
}
