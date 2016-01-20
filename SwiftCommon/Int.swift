//
//  Int.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

public extension Int {
  
  /**
   Calls closure self times.
   
   Example:
   ```
   var i = 0
   3.times() { i++ }
   i  // => 3
   ```
	*/
  public func times(closure: () -> ()) {
    for _ in 0..<self {
      closure()
    }
  }
}
