/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit


// MARK: Reusable support for UITableView

public extension UITableView {
  /**
   Register a NIB-Based `UITableViewCell` subclass (conforming to `NibReusable`)

   - parameter cellType: the `UITableViewCell` (`NibReusable`-conforming) subclass to register

   - seealso: `registerNib(_:,forCellReuseIdentifier:)`
   */
  final func registerReusableCell<T: UITableViewCell where T: NibReusable>(cellType: T.Type) {
    self.registerNib(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
  }

  /**
   Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)

   - parameter cellType: the `UITableViewCell` (`Reusable`-conforming) subclass to register

   - seealso: `register(_:,forCellReuseIdentifier:)`
   */
  final func registerReusableCell<T: UITableViewCell where T: Reusable>(cellType: T.Type) {
    self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }

  /**
   Returns a reusable `UITableViewCell` object for the class inferred by the return-type

   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue

   - returns: A `Reusable`, `UITableViewCell` instance

   - note: The `cellType` parameter can generally be omitted and infered by the return type,
   except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableCellWithIdentifier(_:,forIndexPath:)`
   */
  final func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath: IndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = self.dequeueReusableCellWithIdentifier(cellType.reuseIdentifier, forIndexPath: indexPath) as? T else {
      fatalError(
        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the cell beforehand"
      )
    }
    return cell
  }

  /**
   Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `NibReusable`)

   - parameter viewType: the `UITableViewHeaderFooterView` (`NibReusable`-conforming) subclass to register

   - seealso: `registerNib(_:,forHeaderFooterViewReuseIdentifier:)`
   */
  final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: NibReusable>(viewType: T.Type) {
    self.registerNib(viewType.nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
  }

  /**
   Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)

   - parameter viewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register

   - seealso: `register(_:,forHeaderFooterViewReuseIdentifier:)`
   */
  final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(viewType: T.Type) {
    self.register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
  }

  /**
   Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type

   - parameter viewType: The view class to dequeue

   - returns: A `Reusable`, `UITableViewHeaderFooterView` instance

   - note: The `viewType` parameter can generally be omitted and infered by the return type,
   except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableHeaderFooterView(withIdentifier:)`
   */
  final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(viewType: T.Type = T.self) -> T? {
    guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
      fatalError(
        "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the header/footer beforehand"
      )
    }
    return view
  }
}
