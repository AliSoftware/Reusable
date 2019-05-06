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

    tableView.register(cellType: MySimpleColorCell.self)
    tableView.register(cellType: MyXIBTextCell.self)
    tableView.register(cellType: MyXIBInfoCell.self)

    /* No need to register this one, the UIStoryboard already auto-register its cells */
//    tableView.registerReusableCell(MyStoryBoardIndexPathCell)
  }

  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return MyHeaderTableView.height
  }

  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let frame = CGRect(
      x: 0,
      y: 0,
      width: tableView.bounds.size.width,
      height: self.tableView(tableView, heightForHeaderInSection: section)
    )
    // See the overridden `MyHeaderTableView.init(frame:)` initializer, which
    // automatically loads the view content from its nib using loadNibContent()
    let view = MyHeaderTableView(frame: frame)

    view.fillForSection(section)
    return view
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let colorCell = tableView.dequeueReusableCell(for: indexPath) as MySimpleColorCell
      let redComp: CGFloat = indexPath.row == 0 ? 1.0 : 0.0
      colorCell.fill(UIColor(red: redComp, green: 0.0, blue: 1-redComp, alpha: 1.0))
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
}
