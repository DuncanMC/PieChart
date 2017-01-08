//
//  File.swift
//  PieChart
//
//  Created by Duncan Champney on 4/6/15.
//  Copyright (c) 2015 Duncan Champney. All rights reserved.
//

import Foundation
import UIKit


@objc protocol MyCAAnimationDelegateProtocol
{
  func animationDidStop(_ theAnimation: CAAnimation!, finished flag: Bool)
}
