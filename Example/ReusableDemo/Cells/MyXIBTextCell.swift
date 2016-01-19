//
//  MyXIBTextCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class MyXIBTextCell: UITableViewCell, NibReusable {

  @IBOutlet private weak var titleLabel: UILabel!

  func fill(text: String) {
    titleLabel.text = text
  }
}
