//
//  Sequence.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 20/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

public extension SequenceType {
  
  public func find(predicate: (Self.Generator.Element) -> Bool) -> Self.Generator.Element? {
    for e in self {
      if predicate(e) { return e }
    }
    return nil
  }
}
