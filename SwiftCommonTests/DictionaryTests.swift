//
//  DictionaryTests.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class DictionaryTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_merge() {
    var d = ["a": "1", "b": "2"]
    d.merge(["a": "newa", "c": "3"])
    XCTAssertEqual(["a": "newa", "b": "2", "c": "3"], d)
  }
}
