//
//  SequenceTypeTests.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class SequenceTypeTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_find() {
    let array = [1, 2, 3, 4, 5, 6, 7]
    
    XCTAssertEqual(2, array.find { $0 % 2 == 0 })
  }
}
