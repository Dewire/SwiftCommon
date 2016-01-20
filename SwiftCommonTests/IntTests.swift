//
//  IntTests.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class IntTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_times() {
    var i = 0
    3.times { i++ }
    XCTAssertEqual(3, i)
  }
}
