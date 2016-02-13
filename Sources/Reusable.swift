import UIKit

/// Make your UITableViewCell and UICollectionViewCell subclasses
/// conform to this protocol when they are *not* NIB-based but only code-based
/// to be able to dequeue them in a type-safe manner
public protocol Reusable: class {
  /// The reuse identifier to use when registering and later dequeuing a reusable cell
  static var reuseIdentifier: String { get }
}

/// Make your UITableViewCell and UICollectionViewCell subclasses
/// conform to this protocol when they *are* NIB-based
/// to be able to dequeue them in a type-safe manner
public protocol NibReusable: Reusable, NibLoadable {}

// MARK: - Default implementation for Reusable

public extension Reusable {
  /// By default, use the name of the class as String for its reuseIdentifier
  static var reuseIdentifier: String {
    return String(self)
  }
}

// MARK: - UITableView support for Reusable & NibReusable

public extension UITableView {
  /**
   Register a NIB-Based `UITableViewCell` subclass (conforming to `NibReusable`)

   - parameter cellType: the `UITableViewCell` (`NibReusable`-conforming) subclass to register

   - seealso: `registerNib(_:,forCellReuseIdentifier:)`
   */
  final func registerReusableCell<T: UITableViewCell where T: NibReusable>(cellType: T.Type) {
    self.registerNib(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Register a Class-Based `UITableViewCell` subclass (conforming to `Reusable`)

   - parameter cellType: the `UITableViewCell` (`Reusable`-conforming) subclass to register

   - seealso: `registerClass(_:,forCellReuseIdentifier:)`
   */
  final func registerReusableCell<T: UITableViewCell where T: Reusable>(cellType: T.Type) {
    self.registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Returns a reusable `UITableViewCell` object for the class infered by the return-type

   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue

   - returns: A `Reusable`, `UITableViewCell` instance

   - seealso: `dequeueReusableCellWithIdentifier(_:,forIndexPath:)`
   */
  final func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath: NSIndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = self.dequeueReusableCellWithIdentifier(cellType.reuseIdentifier, forIndexPath: indexPath) as? T else {
      fatalError(
        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). " +
          "Check that the reuseIdentifier is set properly in your XIB/Storyboard " +
        "and that you registered the cell beforehand"
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
    self.registerNib(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `Reusable`)

   - parameter viewType: the `UITableViewHeaderFooterView` (`Reusable`-confirming) subclass to register

   - seealso: `registerClass(_:,forHeaderFooterViewReuseIdentifier:)`
   */
  final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(viewType: T.Type) {
    self.registerClass(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Returns a reusable `UITableViewHeaderFooterView` object for the class infered by the return-type
   
   - parameter viewType: The view class to dequeue
   
   - returns: A `Reusable`, `UITableViewHeaderFooterView` instance

   - seealso: `dequeueReusableHeaderFooterViewWithIdentifier(_:)`
   */
  final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(indexPath: NSIndexPath, viewType: T.Type = T.self) -> T? {
    guard let view = self.dequeueReusableHeaderFooterViewWithIdentifier(viewType.reuseIdentifier) as? T? else {
      fatalError(
        "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). " +
          "Check that the reuseIdentifier is set properly in your XIB/Storyboard " +
        "and that you registered the header/footer beforehand"
      )
    }
    return view
  }
}

// MARK: - UICollectionView support for Reusable & NibReusable

public extension UICollectionView {
  /**
   Register a NIB-Based `UICollectionViewCell` subclass (conforming to `NibReusable`)

   - parameter cellType: the `UICollectionViewCell` (`NibReusable`-conforming) subclass to register

   - seealso: `registerNib(_:,forCellWithReuseIdentifier:)`
   */
  final func registerReusableCell<T: UICollectionViewCell where T: NibReusable>(cellType: T.Type) {
    self.registerNib(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)

   - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register

   - seealso: `registerClass(_:,forCellWithReuseIdentifier:)`
   */
  final func registerReusableCell<T: UICollectionViewCell where T: Reusable>(cellType: T.Type) {
    self.registerClass(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Returns a reusable `UICollectionViewCell` object for the class infered by the return-type

   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue

   - returns: A `Reusable`, `UICollectionViewCell` instance

   - seealso: `dequeueReusableCellWithReuseIdentifier(_:,forIndexPath:)`
   */
  final func dequeueReusableCell<T: UICollectionViewCell where T: Reusable>(indexPath: NSIndexPath, cellType: T.Type = T.self) -> T {
    guard let cell = self.dequeueReusableCellWithReuseIdentifier(cellType.reuseIdentifier, forIndexPath: indexPath) as? T else {
      fatalError(
        "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). " +
          "Check that the reuseIdentifier is set properly in your XIB/Storyboard " +
        "and that you registered the cell beforehand"
      )
    }
    return cell
  }

  /**
   Register a NIB-Based `UICollectionReusableView` subclass (conforming to `NibReusable`) as a Supplementary View

   - parameter elementKind: The kind of supplementary view to create.
   - parameter viewType: the `UIView` (`NibReusable`-conforming) subclass to register as Supplementary View

   - seealso: `registerNib(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
   */
  final func registerReusableSupplementaryView<T: UICollectionReusableView where T: NibReusable>(elementKind: String, viewType: T.Type) {
    self.registerNib(T.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Register a Class-Based `UICollectionReusableView` subclass (conforming to `Reusable`) as a Supplementary View

   - parameter elementKind: The kind of supplementary view to create.
   - parameter viewType: the `UIView` (`Reusable`-conforming) subclass to register as Supplementary View

   - seealso: `registerClass(_:,forSupplementaryViewOfKind:,withReuseIdentifier:)`
   */
  final func registerReusableSupplementaryView<T: UICollectionReusableView where T: Reusable>(elementKind: String, viewType: T.Type) {
    self.registerClass(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
  }

  /**
   Returns a reusable `UICollectionReusableView` object for the class infered by the return-type

   - parameter elementKind: The kind of supplementary view to retrieve.
   - parameter indexPath:   The index path specifying the location of the cell.
   - parameter viewType: The view class to dequeue
   
   - returns: A `Reusable`, `UICollectionReusableView` instance

   - seealso: `dequeueReusableSupplementaryViewOfKind(_:,withReuseIdentifier:,forIndexPath:)`
   */
  final func dequeueReusableSupplementaryView<T: UICollectionReusableView where T: Reusable>(elementKind: String, indexPath: NSIndexPath, viewType: T.Type = T.self) -> T {
    guard let view = self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: viewType.reuseIdentifier, forIndexPath: indexPath) as? T else {
      fatalError(
        "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self). " +
          "Check that the reuseIdentifier is set properly in your XIB/Storyboard " +
        "and that you registered the supplementary view beforehand"
      )
    }
    return view
  }
}
