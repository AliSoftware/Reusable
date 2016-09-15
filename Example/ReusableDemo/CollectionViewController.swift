//
//  CollectionViewController.swift
//  ReusableDemo
//
//  Created by Olivier Halligon on 19/01/2016.
//  Copyright © 2016 AliSoftware. All rights reserved.
//

import Reusable
import UIKit

final class CollectionViewController: UICollectionViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let collectionView = self.collectionView else { return }

    // Register cell classes
    collectionView.registerReusableCell(MyColorSquareCell.self)
    collectionView.registerReusableCell(MyXIBIndexSquaceCell.self)
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

  #if swift(>=3.0)
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 3
    }
  #else
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 3
    }
  #endif

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }

  #if swift(>=3.0)
    override func collectionView(_ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(kind, indexPath: indexPath) as CollectionHeaderView
        header.title = "Section \(indexPath.section)"
        return header
    }
  #else
    override func collectionView(_ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(kind, indexPath: indexPath) as CollectionHeaderView
        header.title = "Section \(indexPath.section)"
        return header
    }
  #endif

  #if swift(>=3.0)
    override func collectionView(_ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
          let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MyColorSquareCell
          let red = CGFloat(indexPath.row) / CGFloat(collectionView.numberOfItems(inSection: indexPath.section))
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
  #else
    override func collectionView(_ collectionView: UICollectionView,
      cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
          let cell = collectionView.dequeueReusableCell(indexPath) as MyColorSquareCell
          let red = CGFloat(indexPath.row) / CGFloat(collectionView.numberOfItemsInSection(indexPath.section))
          cell.fill(UIColor(red: red, green: 0.0, blue: 1.0-red, alpha: 1.0))
          return cell
        case 1:
          let cell = collectionView.dequeueReusableCell(indexPath) as MyStoryboardTextSquareCell
          cell.fill("Item #\(indexPath.row)")
          return cell
        case 2:
          let cell = collectionView.dequeueReusableCell(indexPath) as MyXIBIndexSquaceCell
          cell.fill(indexPath)
          return cell
        default:
          fatalError("Out of bounds, should not happen")
        }
    }
  #endif
}
