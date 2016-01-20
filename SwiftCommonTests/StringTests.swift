//
//  StringTests.swift
//  SwiftCommonTests
//
//  Created by Kalle Lindström on 26/12/15.
//  Copyright © 2015 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class StringTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  // MARK: match and gmatch
  
  func test_match() {
    let m = "I am a duck".match("a\\s+(\\w+)")!
    
    XCTAssertEqual("a duck", m[0])
    XCTAssertEqual("duck", m[1])
  }
  
  func test_match_case() {
    XCTAssertNil("DUCK".match("duck"))

    let m = "DUCK".match("duck", "i")!
    XCTAssertEqual("DUCK", m[0])
  }
  
  func test_match_dot_matches_newline() {
    XCTAssertNil("duck\nduck\ngo".match(".+?(go)"))
    
    let m = "duck\nduck\ngo".match(".+?(go)", "m")!
    XCTAssertEqual("go", m[1])
  }
  
  func test_achors_match_lines() {
    XCTAssertNil("duck\nduck\ngo".match("^go"))
    
    let m = "duck\nduck\ngo".match("^go", "a")!
    XCTAssertEqual("go", m[0])
  }
  
  func test_gmatch() {
    let m = "anka anka duck anka".gmatch("an(ka)")!
    
    XCTAssertEqual(3, m.count)
    XCTAssertEqual("anka", m[0][0])
    XCTAssertEqual("ka", m[0][1])
  }
  
  // MARK: sub and gsub
  
  func test_sub() {
    XCTAssertEqual("Spelling is hard speling",
      "SPeling is hard speling".sub("speling", replacement: "Spelling", "i"))
  }
  
  func test_gsub() {
    let l = "1337 1337 1337!!!"
    let r = l.gsub("3+", replacement: "4")
    XCTAssertEqual("147 147 147!!!", r)
  }
}
