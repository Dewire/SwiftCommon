//
//  FreeFunctions.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 21/01/16.
//  Copyright © 2016 Dewire. All rights reserved.
//

import Foundation

/**
 Wraps a call to NSLocalizedString.
*/
public func L(_ key: String, _ comment: String = "") -> String {
  return NSLocalizedString(key, comment: comment)
}
