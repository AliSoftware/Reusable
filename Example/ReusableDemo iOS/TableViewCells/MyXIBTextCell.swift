//
//  MyXIBTextCell.swift
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
 * It is also reusable and has a `reuseIdentifier` (as it's a TableViewCell
 * and it uses the TableView recycling mechanism) => it is `Reusable`
 *
 * That's why it's annotated with the `NibReusable` typealias,
 * Which in fact is just a convenience typealias that combines
 * `NibLoadable` & `Reusable` protocols.
 */
final class MyXIBTextCell: UITableViewCell, NibReusable, BundledSelf {

  @IBOutlet private weak var titleLabel: UILabel!

  func fill(_ text: String) {
    titleLabel.text = text
  }
}
