//
//  MyXIBSwitchCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class MyXIBSwitchCell: UITableViewCell, NibReusable {

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var valueSwitch: UISwitch!
  private var toggleBlock: (Bool->Void)?

  func fill(title: String, value: Bool, onToggle: (Bool->Void)) {
    titleLabel.text = title
    valueSwitch.on = value
    self.toggleBlock = onToggle
  }

  @IBAction func onSwitchToggle(sender: UISwitch) {
    self.toggleBlock?(sender.on)
  }
}
