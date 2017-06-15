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
  
  func test_any() {
    let array = [1, 2, 3, 4, 5, 6, 7]
    XCTAssertTrue(array.any { $0 > 5 })
    XCTAssertFalse(array.any { $0 > 7 })
  }
  
  func test_all() {
    let array = ["hello", "world"]
    XCTAssertTrue(array.all { $0.characters.count == 5 })
    XCTAssertFalse(array.all { $0.characters.first == "h" })
  }
  
  func test_unique() {
    let array = [1, 1, 2, 1, 3]
    let unique = array.unique()
    XCTAssertEqual(3, unique.count)
    XCTAssert([1, 2, 3].elementsEqual(array.unique()))
  }
}
