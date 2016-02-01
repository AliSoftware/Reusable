//
//  MyColorSquareCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class MyColorSquareCell: UICollectionViewCell, Reusable {
  private lazy var colorView: UIView = {
    let colorView = UIView()
    colorView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    colorView.frame = self.contentView.bounds.insetBy(dx: 10, dy: 10)
    self.contentView.addSubview(colorView)
    return colorView
  }()

  func fill(color: UIColor) {
    self.colorView.backgroundColor = color
  }
}
