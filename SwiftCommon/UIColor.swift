//
//  UIColor.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 2017-09-26.
//  Copyright © 2017 Dewire. All rights reserved.
//

import UIKit

extension UIColor {
  
  /**
   Creates a color given a RGB(A) number. If the number given is less than or equal to 0xFFFFFF
   it is interpreted as a RGB value. If it is greater than 0xFFFFFF it is interpreted as an RGBA value.
   If the number is a RGB value, an optional alpha value can be given from 0 to 1. The default is 1.
   If the number is a RGBA value the optional alpha value is ignored.
   
   Example:
   ```
   UIColor(rgb: 0xFF0000)               # -> same as UIColor.red
   UIColor(rgb: 0xFF0000, alpha: 0.5)   # -> red color with 50% opacity
   UIColor(rgb: 0xFF000080)             # -> rec color with =~ 50% opacity
   ```
   */
  convenience init(rgb: Int64, alpha: CGFloat = 1) {
    let r, g, b: Int64
    let a: CGFloat
    
    if rgb > 0xFFFFFF {                           // we have a RGBA color
      r = (rgb & 0xFF000000) >> 24
      g = (rgb & 0x00FF0000) >> 16
      b = (rgb & 0x0000FF00) >> 8
      a = CGFloat((rgb & 0x000000FF)) / 255
    } else {                                      // we have a RGB color
      r = (rgb & 0xFF0000) >> 16
      g = (rgb & 0x00FF00) >> 8
      b = rgb & 0x0000FF
      a = alpha
    }
    
    self.init(red: CGFloat(r) / 255,
              green: CGFloat(g) / 255,
              blue: CGFloat(b) / 255,
              alpha: a)
  }
}
