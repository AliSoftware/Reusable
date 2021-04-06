//
//  MyXIBIndexSquaceCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

/**
 * This view is loaded from a NIB, and is the XIB file's
 * root view (and not the File's Owner). => it is `NibLoadable`
 *
 * It is also reusable and has a `reuseIdentifier` (as it's a CollectionViewCell
 * and it uses the CollectionView recycling mechanism) => it is `Reusable`
 *
 * That's why it's annotated with the `NibReusable` protocol,
 * Which in fact is just a typealias that combines
 * `NibLoadable` & `Reusable` protocols.
 */
final class MyXIBIndexSquaceCell: UICollectionViewCell, NibReusable, BundledSelf {
  @IBOutlet private weak var sectionLabel: UILabel!
  @IBOutlet private weak var rowLabel: UILabel!

  func fill(_ indexPath: IndexPath) {
    sectionLabel.text = String(indexPath.section)
    rowLabel.text = String(indexPath.row)
  }
}
