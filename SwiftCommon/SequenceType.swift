//
//  SequenceType.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

// MARK: find, any, all

public extension SequenceType {
  
  /**
   Returns the first element in self for which predicate is true, or nil if no element returns
   true.
   
   Example:
   ```
   let array = [1, 2, 3, 4, 5, 6, 7]
   array.find { $0 % 2 == 0 }  // => 2
   ```
	*/
  @warn_unused_result
  public func find(@noescape predicate: (Self.Generator.Element) -> Bool) -> Self.Generator.Element? {
    for e in self {
      if predicate(e) { return e }
    }
    return nil
  }
  
  /**
   Returns true if the sequence contains an element for which the predicate returns true,
   otherwise returns false.
   
   Example:
   ```
   let array = [1, 2, 3, 4, 5, 6, 7]
   array.any { $0 > 5 }  // => true
   array.any { $0 > 7 }  // => false
   ```
	*/
  @warn_unused_result
  public func any(@noescape predicate: (Self.Generator.Element) -> Bool) -> Bool {
    for element in self {
      if predicate(element) { return true }
    }
    return false
  }
  
  /**
   Returns true if the predicate returns true for all elements in the sequence,
   otherwise returns false.
   
   Example:
   ```
   let array = ["hello", "world"]
   array.all { $0.characters.count == 5 }  // => true
   ```
	*/
  @warn_unused_result
  public func all(@noescape predicate: (Self.Generator.Element) -> Bool) -> Bool {
    for element in self {
      if !predicate(element) { return false }
    }
    return true
  }
}
