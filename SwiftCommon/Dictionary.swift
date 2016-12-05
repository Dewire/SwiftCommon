//
//  Dictionary.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

// MARK: merge

public extension Dictionary {
  /**
   Updates self with the values from other.
   
   Example:
   ```
   var d = ["a": "1", "b": "2"]
   d.merge(["a": "newa", "c": "3"])
   d  // => ["a": "newa", "b": "2", "c": "3"]
   ```
	*/
  public mutating func merge(_ other: Dictionary<Key, Value>) {
    for (key, value) in other {
      self.updateValue(value, forKey: key)
    }
  }
  
  /**
   Returns a new Dictionary based on self with updates values
   from the other Dictionary.
   
   Example:
   ```
   ["a": "1", "b": "2"].merge(["a": "3"])["a"]  // => 3

   ```
   */
  public func merged(_ other: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
    var copy = self
    copy.merge(other)
    return copy
  }
}
