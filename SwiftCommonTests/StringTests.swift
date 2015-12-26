//
//  StringTests.swift
//  SwiftCommonTests
//
//  Created by Kalle Lindström on 26/12/15.
//  Copyright © 2015 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class SwiftCommonTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_match() {
    let m = "I am a duck".match("a\\s+(\\w+)")!
    
    XCTAssertEqual("a duck", m[0])
    XCTAssertEqual("duck", m[1])
  }
  
  func test_gmatch() {
    let m = "anka anka duck anka".gmatch("an(ka)")!
    
    XCTAssertEqual(3, m.count)
    XCTAssertEqual("anka", m[0][0])
    XCTAssertEqual("ka", m[0][1])
  }
}



