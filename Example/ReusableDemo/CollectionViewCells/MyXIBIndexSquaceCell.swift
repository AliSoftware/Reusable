//
//  MyXIBIndexSquaceCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class MyXIBIndexSquaceCell: UICollectionViewCell, NibReusable {
  @IBOutlet private weak var sectionLabel: UILabel!
  @IBOutlet private weak var rowLabel: UILabel!

  func fill(indexPath: NSIndexPath) {
    sectionLabel.text = String(indexPath.section)
    rowLabel.text = String(indexPath.row)
  }
}
