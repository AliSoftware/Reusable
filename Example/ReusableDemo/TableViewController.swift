//
//  ViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import Reusable
import UIKit

final class TableViewController: UITableViewController {
  var boolValues = [false, false]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.registerReusableCell(MySimpleColorCell.self)
    tableView.registerReusableCell(MyXIBTextCell.self)
    tableView.registerReusableCell(MyXIBInfoCell.self)
    /* No need to register this one, the UIStoryboard already auto-register its cells */
//    tableView.registerReusableCell(MyStoryBoardIndexPathCell)
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyHeaderTableView.height
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = MyHeaderTableView.loadFromNib()
    view.fillForSection(section)
    return view
  }

  #if swift(>=3.0)
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 4
    }
  #else
    override func numberOfSections(in tableView: UITableView) -> Int {
      return 4
    }
  #endif

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  #if swift(>=3.0)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section {
      case 0:
        let colorCell = tableView.dequeueReusableCell(for: indexPath) as MySimpleColorCell
        let red: CGFloat = indexPath.row == 0 ? 1.0 : 0.0
        colorCell.fill(UIColor(red: red, green: 0.0, blue: 1-red, alpha: 1.0))
        return colorCell
      case 1:
        let textCell = tableView.dequeueReusableCell(for: indexPath) as MyXIBTextCell
        textCell.fill("{section \(indexPath.section), row \(indexPath.row)}")
        return textCell
      case 2:
        let infoCell = tableView.dequeueReusableCell(for: indexPath) as MyXIBInfoCell
        infoCell.fill("InfoCell #\(indexPath.row)", info: "Info #\(indexPath.row)", details: "Details #\(indexPath.row)")
        return infoCell
      case 3:
        let pathCell = tableView.dequeueReusableCell(for: indexPath) as MyStoryBoardIndexPathCell
        pathCell.fill(indexPath)
        return pathCell
      default:
        fatalError("Out of bounds, should not happen")
      }
    }
  #else
    override func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section {
      case 0:
        let colorCell = tableView.dequeueReusableCell(indexPath) as MySimpleColorCell
        let red: CGFloat = indexPath.row == 0 ? 1.0 : 0.0
        colorCell.fill(UIColor(red: red, green: 0.0, blue: 1-red, alpha: 1.0))
        return colorCell
      case 1:
        let textCell = tableView.dequeueReusableCell(indexPath) as MyXIBTextCell
        textCell.fill("{section \(indexPath.section), row \(indexPath.row)}")
        return textCell
      case 2:
        let boolCell = tableView.dequeueReusableCell(indexPath) as MyXIBSwitchCell
        boolCell.fill("Switch #\(indexPath.row)", value: boolValues[indexPath.row]) {
          [unowned self] in self.boolValues[indexPath.row] = $0
        }
        return boolCell
      case 3:
        let pathCell = tableView.dequeueReusableCell(indexPath) as MyStoryBoardIndexPathCell
        pathCell.fill(indexPath)
        return pathCell
      default:
        fatalError("Out of bounds, should not happen")
      }
    }
  #endif
}
