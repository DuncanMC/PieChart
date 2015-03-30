//
//  ViewController.swift
//  PieChart
//
//  Created by Duncan Champney on 3/29/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var thePieChart: PieChartView!
  override func viewDidLoad()
  {
    
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

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

  @IBAction func handleRandomizeButton(sender: UIButton)
  {
    var newSlices: [Slice] = [Slice]()
    for _ in 1...thePieChart.slices.count
    {
      let radius = CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max)
      let width = CGFloat(arc4random_uniform(UInt32.max))/CGFloat(UInt32.max) * 100 + 20
      newSlices.append(Slice(radius: radius, width: width))
    }
    thePieChart.slices = newSlices
  }

}

