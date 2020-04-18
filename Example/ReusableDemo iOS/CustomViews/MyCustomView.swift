//
//  MyCustomView.swift
//  ReusableDemo iOS
//
//  Created by Skoti on 18/04/2020.
//  Copyright © 2020 AliSoftware. All rights reserved.
//

import Reusable
import UIKit

final class MyCustomView: UIView, NibLoadable {

  // MARK: - IBInspectables

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

  // MARK: - Outlets

  @IBOutlet private weak var rectView: UIView!
  @IBOutlet private weak var textLabel: UILabel!

  // MARK: - Lifecycle

  override func awakeAfter(using coder: NSCoder) -> Any? {
    return self.awakeAfterUsingSurrogate()
  }
}
