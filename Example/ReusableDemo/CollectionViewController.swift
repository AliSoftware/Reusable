//
//  CollectionViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let collectionView = self.collectionView else { return }

    // Register cell classes
    collectionView.registerReusableCell(MyColorSquareCell)
    collectionView.registerReusableCell(MyXIBIndexSquaceCell)
    // No need to register this one, the UIStoryboard already auto-register its cells
    //    self.collectionView.registerReusableCell(MyStoryBoardIndexPathCell)

    collectionView.registerReusableSupplementaryView(
      UICollectionElementKindSectionHeader,
      viewType: CollectionHeaderView.self)

    if let flowLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.headerReferenceSize = CGSize(width: collectionView.bounds.size.width, height: 60)
    }
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 3
  }

  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  override func collectionView(collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
      let header = collectionView.dequeueReusableSupplementaryView(kind, indexPath: indexPath) as CollectionHeaderView
      header.title = "Section \(indexPath.section)"
      return header
  }

  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      switch indexPath.section {
      case 0:
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MyColorSquareCell
        let red = CGFloat(indexPath.row) / CGFloat(collectionView.numberOfItemsInSection(indexPath.section))
        cell.fill(UIColor(red: red, green: 0.0, blue: 1.0-red, alpha: 1.0))
        return cell
      case 1:
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MyStoryboardTextSquareCell
        cell.fill("Item #\(indexPath.row)")
        return cell
      case 2:
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MyXIBIndexSquaceCell
        cell.fill(indexPath)
        return cell
      default:
        fatalError("Out of bounds, should not happen")
      }
  }
}
