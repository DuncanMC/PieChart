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
@IBDesignable
class PieChartView: UIView, CAAnimationDelegate
{
  var animating: Bool = false
  var dontAnimatePathChanges: Bool = false
  var myAnimationDelegate: MyCAAnimationDelegateProtocol?
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
    
    if let myShapeLayer = myShapeLayer
    {
      myShapeLayer.removeAllAnimations()
      //First count the total width value so we can make the size of each slice proportional
      for aSlice in slices
      {
        totalWidth += aSlice.width
      }
      
      //Setup for building our path.
      let path = UIBezierPath()
      let center = CGPoint(x: myShapeLayer.bounds.midX,
        y: myShapeLayer.bounds.midY)
      path.move(to: center)
      var startAngle:CGFloat = 0.0
      let maxRadius:CGFloat = min(self.bounds.size.width,
        self.bounds.size.height)/2 - 5
      
      //Loop through each slice
      for aSlice in slices
      {
        let endAngle:CGFloat = startAngle + aSlice.width / totalWidth * CGFloat(M_PI) * 2.0
        let thisRadius = maxRadius * aSlice.radius
        path.addArc(withCenter: center,
          radius: thisRadius,
          startAngle: startAngle,
          endAngle: endAngle,
          clockwise: true)
        path.addLine(to: center)
        path.close()
        //
        startAngle = endAngle
      }
      /*
        If the number of slices is the same as last time, animate the change
        If the number of slices changed then animation won't work
        (path animation requires that the start and end path have the same number of control points
      */
      if oldSliceCount == slices.count && !animating
      {
        //Create a CABasicAnimation to animate the path
        let pathAnimation = CABasicAnimation(keyPath: "path")
        
        //Make the animation start from the old path
        if let oldPath = myShapeLayer.path
        {
          pathAnimation.fromValue = oldPath as AnyObject
        }
        
        //Animate the changes to the path
        pathAnimation.toValue = path.cgPath as AnyObject
        pathAnimation.duration = 0.3
        //pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        myShapeLayer.path = path.cgPath
        pathAnimation.delegate = self
        animating = true
        myShapeLayer.add(pathAnimation, forKey: "path")
      }
      else
      {
        myShapeLayer.path = path.cgPath
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
        alpha: 0.5).cgColor

      requiredShapeLayer.fillColor = UIColor.cyan.cgColor
      
      requiredShapeLayer.borderWidth = 1
      requiredShapeLayer.borderColor = UIColor(
        red: 0,
        green: 0,
        blue: 0,
        alpha: 0.2).cgColor
      self.layer.addSublayer(myShapeLayer!)
    }
    self.slices = [
      Slice(radius: 1.0, width: 0.1),
      Slice(radius: 0.7, width: 0.15),
      Slice(radius: 0.6, width: 0.125),
      Slice(radius: 0.4, width: 0.0625),
      Slice(radius: 0.75, width: 0.1875),
      Slice(radius: 0.5, width: 0.125),
      Slice(radius: 0.3, width: 0.3),
      Slice(radius: 1.0, width: 0.1),
      Slice(radius: 1.0, width: 0.1),
      Slice(radius: 0.7, width: 0.15),
      Slice(radius: 0.6, width: 0.125),
      Slice(radius: 0.4, width: 0.0625),
      Slice(radius: 0.75, width: 0.1875),
      Slice(radius: 0.5, width: 0.125),
      Slice(radius: 0.3, width: 0.3),
      Slice(radius: 1.0, width: 0.1)
    ]

  }
  
  override init(frame: CGRect)
  {
    myShapeLayer = CAShapeLayer()
    super.init(frame: frame)
    self.setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {

    print("In \(#function)")
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
    myShapeLayer?.removeAllAnimations()
    self.updatePath()
  }
  
  func animationDidStop(_ theAnimation: CAAnimation, finished: Bool)
  {
    if myAnimationDelegate != nil
    {
      animating = false
      myAnimationDelegate?.animationDidStop( theAnimation, finished: finished)
    }
  }
}
