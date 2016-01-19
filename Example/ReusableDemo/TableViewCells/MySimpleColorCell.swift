//
//  MySimpleColorCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class MySimpleColorCell: UITableViewCell, Reusable {
  private lazy var colorView: UIView = {
    let colorView = UIView()
    colorView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight]
    colorView.frame = self.contentView.bounds.insetBy(dx: 50, dy: 5)
    self.contentView.addSubview(colorView)
    return colorView
  }()
  
  func fill(color: UIColor) {
    self.colorView.backgroundColor = color
  }
}
