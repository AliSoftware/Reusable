//
//  MyStoryBoardIndexPathCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

// This one can be either NibReusable or just Reusable it doesn't matter actually
// As we will never have to explicitly call tableView.register(…) to register it:
// The Main.storyboard already auto-registers its cells without the need for additional code

class MyStoryBoardIndexPathCell: UITableViewCell, Reusable {
  @IBOutlet private weak var sectionLabel: UILabel!
  @IBOutlet private weak var rowLabel: UILabel!

  func fill(_ indexPath: IdxPath) {
    sectionLabel.text = String(indexPath.section)
    rowLabel.text = String(indexPath.row)
  }
}
