//
//  SequenceType.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

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
  public func find(@noescape predicate: (Self.Generator.Element) -> Bool) -> Self.Generator.Element? {
    for e in self {
      if predicate(e) { return e }
    }
    return nil
  }
}
