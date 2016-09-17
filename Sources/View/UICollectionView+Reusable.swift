/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit


// MARK: Reusable support for UICollectionView

public extension UICollectionView {
  /**
   Register a NIB-Based `UICollectionViewCell` subclass (conforming to `NibReusable`)

   - parameter cellType: the `UICollectionViewCell` (`NibReusable`-conforming) subclass to register

   - seealso: `register(_:,forCellWithReuseIdentifier:)`
   */
  final func registerReusableCell<T: UICollectionViewCell where T: NibReusable>(_ cellType: T.Type) {
    #if swift(>=3.0)
      self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    #else
      self.registerNib(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    #endif
  }

  /**
   Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)

   - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register

   - seealso: `register(_:,forCellWithReuseIdentifier:)`
   */
  final func registerReusableCell<T: UICollectionViewCell where T: Reusable>(_ cellType: T.Type) {
    #if swift(>=3.0)
      self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    #else
      self.registerClass(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    #endif
  }

  /**
   Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type

   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue

   - returns: A `Reusable`, `UICollectionViewCell` instance

   - note: The `cellType` parameter can generally be omitted and infered by the return type,
   except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableCell(withReuseIdentifier:,for:)`
   */
  final func dequeueReusableCell<T: UICollectionViewCell where T: Reusable>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
    #if swift(>=3.0)
      let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
    #else
      let cell = self.dequeueReusableCellWithReuseIdentifier(cellType.reuseIdentifier, forIndexPath: indexPath)
    #endif
    guard let reusable = cell as? T else {
      fatalError(
        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the cell beforehand"
      )
    }
    return reusable
  }

  /**
   Register a NIB-Based `UICollectionReusableView` subclass (conforming to `NibReusable`) as a Supplementary View

   - parameter elementKind: The kind of supplementary view to create.
   - parameter viewType: the `UIView` (`NibReusable`-conforming) subclass to register as Supplementary View

   - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
   */
  final func registerReusableSupplementaryView<T: UICollectionReusableView where T: NibReusable>(_ elementKind: String, viewType: T.Type) {
    #if swift(>=3.0)
      self.register(viewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    #else
      self.registerNib(viewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    #endif
  }

  /**
   Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View

   - parameter elementKind: The kind of supplementary view to create.
   - parameter viewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View

   - seealso: `register(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
   */
  final func registerReusableSupplementaryView<T: UICollectionReusableView where T: Reusable>(_ elementKind: String, viewType: T.Type) {
    #if swift(>=3.0)
      self.register(viewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    #else
      self.registerClass(viewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier)
    #endif
  }

  /**
   Returns a reusable `UICollectionReusableView` object for the class inferred by the return-type

   - parameter elementKind: The kind of supplementary view to retrieve.
   - parameter indexPath:   The index path specifying the location of the cell.
   - parameter viewType: The view class to dequeue

   - returns: A `Reusable`, `UICollectionReusableView` instance

   - note: The `viewType` parameter can generally be omitted and infered by the return type,
   except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:,for:)`
   */
  final func dequeueReusableSupplementaryView<T: UICollectionReusableView where T: Reusable>
    (_ elementKind: String, indexPath: IndexPath, viewType: T.Type = T.self) -> T {
    #if swift(>=3.0)
      let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath)
    #else
      let view = self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: viewType.reuseIdentifier, forIndexPath: indexPath)
    #endif
    guard let typedView = view as? T else {
      fatalError(
        "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the supplementary view beforehand"
      )
    }
    return typedView
  }
}
