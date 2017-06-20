//
//  UIView.swift
//  SwiftCommon
//
//  Created by Kalle Lindström on 2017-06-20.
//  Copyright © 2017 Dewire. All rights reserved.
//

import UIKit

public extension UIWindow {
  
  /**
   Returns the current visible view controller or nil starting the search from the window's root view controller.
   */
  public var visibleViewController: UIViewController? {
    return UIWindow.getVisibleViewController(from: self.rootViewController)
  }
  
  /**
   Returns the current visible view controller or nil starting the search from the given view controller.
   */
  public static func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {
    if let nc = vc as? UINavigationController {
      return UIWindow.getVisibleViewController(from: nc.visibleViewController)
    } else if let tc = vc as? UITabBarController {
      return UIWindow.getVisibleViewController(from: tc.selectedViewController)
    } else {
      if let pvc = vc?.presentedViewController {
        return UIWindow.getVisibleViewController(from: pvc)
      } else {
        return vc
      }
    }
  }
}
