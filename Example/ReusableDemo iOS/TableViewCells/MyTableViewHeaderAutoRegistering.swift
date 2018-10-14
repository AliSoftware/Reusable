//
//  MyAutoRegisterHeaderTableView.swift
//  ReusableDemo
//
//  Created by TJB on 07/08/18.
//  Copyright © 2018 ApptekStudios. All rights reserved.
//

import UIKit
import Reusable

/**
 * This view is loaded from a NIB, and is the XIB file's
 * root view (and not the File's Owner). => it is `NibLoadable`
 *
 * It is also reusable and has a `reuseIdentifier` (as it's a TableViewHeaderFooterView
 * and it uses the TableView recycling mechanism) => it is `Reusable`
 *
 * That's why it's annotated with the `NibReusable` typealias,
 * Which in fact is just a convenience typealias that combines
 * `NibLoadable` & `Reusable` protocols.
 */
final class MyTableViewHeaderAutoRegistering: UITableViewHeaderFooterView, NibReusable, AutoRegistering {

  @IBOutlet private weak var titleLabel: UILabel!

  static let height: CGFloat = 55

  func fillForSection(_ section: Int) {
    self.titleLabel.text = "Header Section #\(section)"
  }
}
