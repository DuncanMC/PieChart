//
//  ViewController.swift
//  PieChart
//
//  Created by Duncan Champney on 3/29/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MyCAAnimationDelegateProtocol
{

  //-------------------------------------------------------------------------------------------------------
  // MARK: - IBOutlets -
  //-------------------------------------------------------------------------------------------------------

  @IBOutlet weak var sliceCountSlider: UISlider!
  @IBOutlet weak var sliceCountField: UITextField!
  @IBOutlet weak var varyRadiusSwitch: UISwitch!
  @IBOutlet weak var varyWidthSwitch: UISwitch!
  @IBOutlet weak var animateSwitch: UISwitch!
  @IBOutlet weak var thePieChart: PieChartView!
  
  // MARK: -

  var sliceCount: Int = 0
    {
    didSet(newValue)
    {
      sliceCountSlider!.value = Float(sliceCount)
      sliceCountField.text = "\(sliceCount)"
    }
    
  }
  
  //-------------------------------------------------------------------------------------------------------
  // MARK: - View controller methods -
  //-------------------------------------------------------------------------------------------------------

  override func viewDidLoad()
  {
    
    sliceCountField.text = "\(sliceCount)"
    sliceCount = 16
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    thePieChart.myAnimationDelegate = self
  }

  //-------------------------------------------------------------------------------------------------------
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    var useWidths = false
    if useWidths
    {
    thePieChart.slices = [
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
    else
    {
      thePieChart.slices = [
        Slice(radius: 1.0),
        Slice(radius: 0.7),
        Slice(radius: 0.6),
        Slice(radius: 0.4),
        Slice(radius: 1.0),
        Slice(radius: 0.5),
        Slice(radius: 0.3),
        Slice(radius: 0.15),
        Slice(radius: 1.0),
        Slice(radius: 0.7),
        Slice(radius: 0.6),
        Slice(radius: 1.0),
        Slice(radius: 0.75),
        Slice(radius: 0.5),
        Slice(radius: 0.3),
        Slice(radius: 0.2)
      ]
      
    }


  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  //-------------------------------------------------------------------------------------------------------
  // MARK: - IBAction methods -
  //-------------------------------------------------------------------------------------------------------
  @IBAction func handleAnimateSwitch(sender: UISwitch)
  {
  }

  @IBAction func handleSlider(sender: UISlider)
  {
    let value = sender.value
    sliceCount = Int(value)
  }
  
  @IBAction func handleRandomizeButton(sender: UIButton?)
  {
    let varyRadii = varyRadiusSwitch!.on
    let varyWidth = varyWidthSwitch!.on
    let radiusFraction = CGFloat(1.0) / CGFloat(thePieChart.slices.count)
    var newSlices: [Slice] = [Slice]()
    for _ in 1...sliceCount
    {
      let radius = varyRadii ? CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max) : 1
      let width = varyWidth ? CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max) * 100 + 20 : radiusFraction
      newSlices.append(Slice(radius: radius, width: width))
    }
    thePieChart.slices = newSlices
  }
  
  //-------------------------------------------------------------------------------------------------------
  // MARK: - MyCAAnimationDelegateProtocol methods -
  //-------------------------------------------------------------------------------------------------------
  
  override func animationDidStop(theAnimation: CAAnimation!, finished flag: Bool)
  {
    if animateSwitch.on
    {
      self.handleRandomizeButton(nil)
    }
  }

}

