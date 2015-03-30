//
//  Utils.swift
//  PieChart
//
//  Created by Duncan Champney on 3/30/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit




extension CALayer
{
  var borderUIColor: UIColor
  {
    set
    {
      self.borderColor = newValue.CGColor
    }
    get
    {
      return UIColor(CGColor: self.borderColor)
    }
  }
}