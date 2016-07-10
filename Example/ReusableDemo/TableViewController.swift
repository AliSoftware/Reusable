//
//  ViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

final class TableViewController: UITableViewController {
  var boolValues = [false, false]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.registerReusableCell(MySimpleColorCell)
    tableView.registerReusableCell(MyXIBTextCell)
    tableView.registerReusableCell(MyXIBInfoCell)
    /* No need to register this one, the UIStoryboard already auto-register its cells */
//    tableView.registerReusableCell(MyStoryBoardIndexPathCell)
  }

  override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyHeaderTableView.height
  }

  override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = MyHeaderTableView.loadFromNib()
    view.fillForSection(section)
    return view
  }

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 4
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let colorCell = tableView.dequeueReusableCell(indexPath: indexPath) as MySimpleColorCell
      let red: CGFloat = indexPath.row == 0 ? 1.0 : 0.0
      colorCell.fill(UIColor(red: red, green: 0.0, blue: 1-red, alpha: 1.0))
      return colorCell
    case 1:
      let textCell = tableView.dequeueReusableCell(indexPath: indexPath) as MyXIBTextCell
      textCell.fill("{section \(indexPath.section), row \(indexPath.row)}")
      return textCell
    case 2:
      let infoCell = tableView.dequeueReusableCell(indexPath: indexPath) as MyXIBInfoCell
      infoCell.fill("InfoCell #\(indexPath.row)", info: "Info #\(indexPath.row)", details: "Details #\(indexPath.row)")
      return infoCell
    case 3:
      let pathCell = tableView.dequeueReusableCell(indexPath: indexPath) as MyStoryBoardIndexPathCell
      pathCell.fill(indexPath)
      return pathCell
    default:
      fatalError("Out of bounds, should not happen")
    }
  }
}
