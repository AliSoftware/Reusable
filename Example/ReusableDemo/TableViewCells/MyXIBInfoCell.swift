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
class MyXIBInfoCell: UITableViewCell, NibReusable {

  @IBOutlet private weak var titleLabel: UILabel!
  private var info: String = "<Info?>"
  private var details: String = "<Details?>"

  func fill(title: String, info: String, details: String) {
    self.titleLabel.text = title
    self.info = info
    self.details = details
  }

  @IBAction func infoAction(sender: UIButton) {
    let infoVC = InfoViewController.instantiate()
    infoVC.setInfo(self.info)
    self.window?.rootViewController?.presentViewController(infoVC, animated: true, completion: nil)
  }

  @IBAction func detailsAction(sender: UIButton) {
    let detailsVC = InfoDetailViewController.instantiate()
    detailsVC.setDetails(self.details)
    self.window?.rootViewController?.presentViewController(detailsVC, animated: true, completion: nil)

  }
}
