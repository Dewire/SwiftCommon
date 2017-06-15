//
//  SequenceType.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

// MARK: find, any, all

public extension Sequence {
  
  /**
   Returns the first element in self for which predicate is true, or nil if no element returns
   true.
   
   Example:
   ```
   let array = [1, 2, 3, 4, 5, 6, 7]
   array.find { $0 % 2 == 0 }  // => 2
   ```
	*/
  public func find(_ predicate: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
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
  public func any(_ predicate: (Self.Iterator.Element) -> Bool) -> Bool {
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
  public func all(_ predicate: (Self.Iterator.Element) -> Bool) -> Bool {
    for element in self {
      if !predicate(element) { return false }
    }
    return true
  }
}

// MARK: unique

public extension Sequence where Iterator.Element: Hashable {
  
  /**
   Returns an array where duplicated elements are removed. The original order is kept.
   Example:
   ```
   let array = [1, 1, 2, 1, 3]
   array.unique // => [1, 2, 3]
   ```
   */
  public func unique() -> [Iterator.Element] {
    var buffer: [Iterator.Element] = []
    var lookup = Set<Iterator.Element>()
    
    for element in self {
      guard !lookup.contains(element) else { continue }
      
      buffer.append(element)
      lookup.insert(element)
    }
    
    return buffer
  }
}

public extension Sequence where Iterator.Element: Equatable {
  
  /**
   Returns an array where duplicated elements are removed. The original order is kept.
   Example:
   ```
   let array = [1, 1, 2, 1, 3]
   array.unique // => [1, 2, 3]
   ```
   */
  public func unique() -> [Iterator.Element] {
    var buffer: [Iterator.Element] = []
    
    for element in self {
      guard !buffer.contains(element) else { continue }
      
      buffer.append(element)
    }
    
    return buffer
  }
}
