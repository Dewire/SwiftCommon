//
//  Array.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 21/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation


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
  public func sample(amount: Int) -> [Element] {
    guard amount > 0     else { return [] }
    guard amount < count else { return shuffle() }
    
    var shuffled = self
    let lastIndex = shuffled.count - 1
    var cursor = lastIndex
    
    amount.times {
      let randomIndex = Int(arc4random_uniform(UInt32(cursor + 1)))
      
      // Swap index and randomIndex
      let temp = shuffled[cursor]
      shuffled[cursor] = shuffled[randomIndex]
      shuffled[randomIndex] = temp
      
      --cursor
    }
    
    return Array(shuffled[(cursor + 1)...lastIndex])
  }
  
  /// Returns a shuffled copy of self. If self is empty returns self.
  public func shuffle() -> [Element] {
    guard count > 1 else { return self }
    
    var shuffled = self
    var cursor = shuffled.count - 1
    
    cursor.times {
      let randomIndex = Int(arc4random_uniform(UInt32(cursor + 1)))
      
      // Swap index and randomIndex
      let temp = shuffled[cursor]
      shuffled[cursor] = shuffled[randomIndex]
      shuffled[randomIndex] = temp
      
      --cursor
    }
    
    return shuffled
  }
}
