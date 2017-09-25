//
//  Array.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 21/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

// MARK: sample, shuffle

public extension Array {
  
  /**
   Returns a random element from self or nil if self is empty.
	*/
  public func sample() -> Element? {
    guard !isEmpty else { return nil }
    
    let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
    return self[randomIndex]
  }
  
  /**
   Returns amount random elements from self. If amount < 1 an empty array is returned,
   and if amount >= count count random elements is returned (the array is shuffled).
   */
  public func sample(_ amount: Int) -> [Element] {
    guard amount > 0     else { return [] }
    guard amount < count else { return shuffled() }
    
    var copy = self
    var cursor = copy.endIndex - 1
    
    amount.times {
      let randomIndex = Int(arc4random_uniform(UInt32(cursor + 1)))
      
      if randomIndex != cursor {
        copy.swapAt(cursor, randomIndex)
      }
      
      cursor -= 1
    }
    
    return Array(copy[(cursor + 1)..<copy.endIndex])
  }
  
  /// Returns a shuffled copy of self. If self is empty returns self.
  public func shuffled() -> [Element] {
    guard count > 1 else { return self }
    
    var shuffled = self
    var cursor = shuffled.count - 1
    
    cursor.times {
      let randomIndex = Int(arc4random_uniform(UInt32(cursor + 1)))
      
      // Swap index and randomIndex
      let temp = shuffled[cursor]
      shuffled[cursor] = shuffled[randomIndex]
      shuffled[randomIndex] = temp
      
      cursor -= 1
    }
    
    return shuffled
  }
}
