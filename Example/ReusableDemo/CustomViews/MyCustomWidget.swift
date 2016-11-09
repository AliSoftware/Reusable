//
//  MyCustomWidget.swift
//  ReusableDemo
//
//  Created by Olivier HALLIGON on 18/08/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

class MyCustomWidget: UIView, NibOwnerLoadable {
  @IBInspectable var rectColor: UIColor? {
    didSet {
      self.rectView.backgroundColor = self.rectColor
    }
  }
  @IBInspectable var text: String? {
    didSet {
      self.textLabel.text = self.text
    }
  }

  @IBOutlet fileprivate var rectView: UIView!
  @IBOutlet fileprivate var textLabel: UILabel!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    MyCustomWidget.loadFromNib(owner: self)
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
}
