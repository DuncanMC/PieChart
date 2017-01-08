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
  /*
  This custom property lets you set a layer's border color from Interface builder using a 
  "User Defined Runtime Attribute".
  IB's color setting creates a UIColor, but a layer's color is a CGColor. This method simply accepts a UIColor
  and converts it to a CGColor.
  
  To use it, set the layer's border color by making the keypath of the User Defined Runtime Attribute
  layer.borderUIColor
  */
  var borderUIColor: UIColor
  {
    set
    {
      self.borderColor = newValue.cgColor
    }
    get
    {
      return UIColor(cgColor: self.borderColor!)
    }
  }
  
  /*
  This custom property lets you set a layer's background color from Interface builder using a 
  "User Defined Runtime Attribute".
  IB's color setting creates a UIColor, but a layer's color properties use CGColors. 
  This method simply accepts a UIColor and converts it to a CGColor.
  
  To use it, set the layer's border color by making the keypath of the User Defined Runtime Attribute
  layer.backgroundUIColor
  */
  var backgroundUIColor: UIColor
    {
    set
    {
      self.backgroundColor = newValue.cgColor
    }
    get
    {
      return UIColor(cgColor: self.backgroundColor!)
    }
  }
}
