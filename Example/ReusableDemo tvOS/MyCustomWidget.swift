//
//  MyCustomWidget.swift
//  ReusableDemo
//
//  Created by Olivier HALLIGON on 16/02/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
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

  @IBOutlet private var rectView: UIView!
  @IBOutlet private var textLabel: UILabel!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
  }
}
