//
//  ArrayTests.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 21/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class ArrayTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_sample() {
    let a = [1, 2, 3, 4, 5]
    let s = a.sample()!
    XCTAssertTrue(a.contains(s))
    
    let empty = Array<Int>()
    let s2 = empty.sample()
    XCTAssertNil(s2)
  }
  
  func test_sample_amount() {
    let a = [1, 2, 3, 4, 5]
    
    // Border cases
    XCTAssertTrue(a.sample(0).isEmpty)
    XCTAssertTrue(a.sample(-2321).isEmpty)
    XCTAssertEqual(5, a.sample(5).count)
   	XCTAssertEqual(5, a.sample(0xBEEF).count)
    
    let s = a.sample(3)
    XCTAssertEqual(3, s.count)
    
    for e in s {
      XCTAssertTrue(a.contains(e))
    }
  }
  
  func test_shuffle() {
    // Test empty
    let empty = [Int]()
    XCTAssertTrue(empty.shuffle().isEmpty)
    
    // Test 1 element
    let one = [1]
    XCTAssertEqual(1, one.shuffle()[0])
    
    let a = ["an", "array", "of", "strings", "!"]
    let s = a.shuffle()
    XCTAssertEqual(5, s.count)
    
    for x in s {
      XCTAssertTrue(a.contains(x))
    }
  }
}
