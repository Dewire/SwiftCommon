//
//  Dictionary.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

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
  public mutating func merge(other: Dictionary) {
    for (key, value) in other {
      self.updateValue(value, forKey: key)
    }
  }
}
