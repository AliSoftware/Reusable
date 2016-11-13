//
//  MyStoryboardTextSquareCell.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit
import Reusable

/**
 * This one can be either NibReusable or just Reusable it doesn't really matter,
 * as we will never have to explicitly call collectionView.register(…) to register it:
 * The `Main.storyboard` already auto-registers its cells without the need for additional code
 *
 * The only difference in marking a view `NibReusable` vs. `Reusable` is the way
 * `registerCell` is implemented, and as we won't need to call that method anyway
 * because the storyboard will register the cell for us, this makes no difference here.
 */
final class MyStoryboardTextSquareCell: UICollectionViewCell, Reusable {
  @IBOutlet private weak var titleLabel: UILabel!
  func fill(_ text: String) {
    titleLabel.text = text
  }
}
