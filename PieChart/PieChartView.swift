//
//  PieChartView.swift
//  PieChart
//
//  Created by Duncan Champney on 3/29/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit
import Darwin


//-------------------------------------------------------------------------------------------------------

struct Slice
{
  var radius: CGFloat
  var width:  CGFloat
  init(
    radius:     CGFloat = 1,
    width:      CGFloat = 0.125
    )
  {
    self.radius = radius
    self.width = width
  }
}

//-------------------------------------------------------------------------------------------------------

class PieChartView: UIView
{
  var oldSliceCount = 0
  var slices: [Slice] = []
    {
    didSet
    {
      self.updatePath()
    }
  }
  let myShapeLayer: CAShapeLayer?

  //Build a path for our pie graph based on the array slices.
  func updatePath()
  {
    var totalWidth:CGFloat = 0.0
    
    //If the array is empty, return.
    if slices.count == 0
    {
      return
    }
    
    if let requiredShapeLayer = myShapeLayer
    {
      //First count the total width value so we can make the size of each slice proportional
      for aSlice in slices
      {
        totalWidth += aSlice.width
      }
      
      //Setup for building our path.
      let path = UIBezierPath()
      let center = CGPointMake(CGRectGetMidX(requiredShapeLayer.bounds),
        CGRectGetMidY(requiredShapeLayer.bounds))
      path.moveToPoint(center)
      var startAngle:CGFloat = 0.0
      let maxRadius:CGFloat = min(self.bounds.size.width,
        self.bounds.size.height)/2 - 5
      
      //Loop through each slice
      for (index, aSlice) in enumerate(slices)
      {
        let endAngle:CGFloat = startAngle + aSlice.width / totalWidth * CGFloat(M_PI) * 2.0
        let thisRadius = maxRadius * aSlice.radius
        path.addArcWithCenter(center,
          radius: thisRadius,
          startAngle: startAngle,
          endAngle: endAngle,
          clockwise: true)
        path.addLineToPoint(center)
        path.closePath()
        //
        startAngle = endAngle
      }
      /*
        If the number of slices is the same as last time, animate the change
        If the number of slices changed then animation won't work
        (path animation requires that the start and end path have the same number of control points
      */
      if oldSliceCount == slices.count
      {
        //Create a CABasicAnimation to animate the path
        let pathAnimation = CABasicAnimation(keyPath: "path")
        
        //Make the animation start from the old path
        if let oldPath = requiredShapeLayer.path
        {
          pathAnimation.fromValue = oldPath as AnyObject
        }
        
        //Animate the changes to the path
        pathAnimation.toValue = path.CGPath as AnyObject
        pathAnimation.duration = 0.2
        requiredShapeLayer.path = path.CGPath
        requiredShapeLayer.addAnimation(pathAnimation, forKey: "path")
      }
      else
      {
        requiredShapeLayer.path = path.CGPath
      }
      oldSliceCount = slices.count
    }
  }
  
  //-------------------------------------------------------------------------------------------------------

  func setup()
  {
    if let requiredShapeLayer = myShapeLayer
    {
      requiredShapeLayer.frame = frame
      requiredShapeLayer.strokeColor = UIColor(
        red: 0,
        green: 0,
        blue: 0,
        alpha: 0.5).CGColor

      requiredShapeLayer.fillColor = UIColor.cyanColor().CGColor
      
      requiredShapeLayer.borderWidth = 1
      requiredShapeLayer.borderColor = UIColor(
        red: 0,
        green: 0,
        blue: 0,
        alpha: 0.2).CGColor
      self.layer.addSublayer(myShapeLayer)
    }
  }
  
  override init(frame: CGRect)
  {
    myShapeLayer = CAShapeLayer()
    super.init(frame: frame)
    self.setup()
  }
  
  required init(coder aDecoder: NSCoder)
  {
    myShapeLayer = CAShapeLayer()
    super.init(coder: aDecoder)
    self.setup()
  }
  
  //-------------------------------------------------------------------------------------------------------

  override func layoutSubviews()
  {
    super.layoutSubviews()
    if let requiredShapeLayer = myShapeLayer
    {
      requiredShapeLayer.frame = self.layer.bounds
    }
    self.updatePath()
  }
  
}
