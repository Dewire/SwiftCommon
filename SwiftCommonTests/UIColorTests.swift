//
//  UIColorTests.swift
//  SwiftCommonTests
//
//  Created by Kalle Lindström on 2017-09-26.
//  Copyright © 2017 Dewire. All rights reserved.
//

import XCTest
@testable import SwiftCommon

class UIColorTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_rgb() {
    
    let (r, g, b, a) = UIColor(rgb: 0xFF0000).colors
    
    XCTAssertEqual(1.0, r)
    XCTAssertEqual(0, g)
    XCTAssertEqual(0, b)
    XCTAssertEqual(1.0, a)
  }
  
  func test_rgb_alpha() {
    
    let (r, g, b, a) = UIColor(rgb: 0xFF0000, alpha: 0.4).colors
    
    XCTAssertEqual(1.0, r)
    XCTAssertEqual(0, g)
    XCTAssertEqual(0, b)
    XCTAssertEqual(0.4, a, accuracy: 0.0001)
  }
  
  func test_rgba() {
    
    let (r, g, b, a) = UIColor(rgb: 0xFF0000CC, alpha: 0.4).colors
    
    XCTAssertEqual(1.0, r)
    XCTAssertEqual(0, g)
    XCTAssertEqual(0, b)
    XCTAssertEqual(0xCC / 255.0, a, accuracy: 0.0001)
  }
}

fileprivate extension UIColor {
  var colors: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
    var r = CGFloat()
    var g = CGFloat()
    var b = CGFloat()
    var a = CGFloat()
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
}

