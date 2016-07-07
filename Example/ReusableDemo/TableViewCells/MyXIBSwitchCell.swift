//
//  MyXIBSwitchCell.swift
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
 * That's why it's annotated with the `NibReusable` protocol,
 * Which in fact is just a convenience protocol that combines
 * both `NibLoadable` + `Reusable` protocols.
 */
class MyXIBSwitchCell: UITableViewCell, NibReusable {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var valueSwitch: UISwitch!
  private var toggleBlock: ((Bool)->Void)?

  func fill(_ title: String, value: Bool, onToggle: ((Bool)->Void)) {
    titleLabel.text = title
    valueSwitch.isOn = value
    self.toggleBlock = onToggle
  }

  @IBAction func onSwitchToggle(_ sender: UISwitch) {
    self.toggleBlock?(sender.isOn)
  }
}

#if swift(>=3.0)
  /* UISwitch.isOn is already defined */
#else
  /// Adds `isOn` property alias for `on`
  extension UISwitch {
    @nonobjc var isOn: Bool {
      get {
        return on
      }
      set {
        on = newValue
      }
    }
  }
#endif
