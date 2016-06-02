//
//  MyHeaderTableViex.swift
//  ReusableDemo
//
//  Created by Allan Vialatte on 29/05/16.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

class MyHeaderTableView: UIView, NibOwnerLoadable {

  @IBOutlet private weak var titleLabel: UILabel!
  static let height: CGFloat = 55

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func fillForSection(section: Int) {
    self.titleLabel.text = "Header Section #\(section)"
  }
}
