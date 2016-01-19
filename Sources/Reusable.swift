import UIKit

protocol Reusable: class {
  static var reuseIdentifier: String { get }
  static var nib: UINib? { get }
}

extension Reusable {
  static var reuseIdentifier: String { return String(Self) }
  static var nib: UINib? { return nil }
}

extension UITableView {
  func registerReusableCell<T: UITableViewCell where T: Reusable>(_: T.Type) {
    if let nib = T.nib {
      self.registerNib(nib, forCellReuseIdentifier: T.reuseIdentifier)
    } else {
      self.registerClass(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableCell<T: UITableViewCell where T: Reusable>(indexPath indexPath: NSIndexPath) -> T {
    return self.dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
  }

  func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>(_: T.Type) {
    if let nib = T.nib {
      self.registerNib(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    } else {
      self.registerClass(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView where T: Reusable>() -> T? {
    return self.dequeueReusableHeaderFooterViewWithIdentifier(T.reuseIdentifier) as! T?
  }
}

extension UICollectionView {
  func registerReusableCell<T: UICollectionViewCell where T: Reusable>(_: T.Type) {
    if let nib = T.nib {
      self.registerNib(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    } else {
      self.registerClass(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableCell<T: UICollectionViewCell where T: Reusable>(indexPath indexPath: NSIndexPath) -> T {
    return self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as! T
  }

  func registerReusableSupplementaryView<T: Reusable>(elementKind: String, _: T.Type) {
    if let nib = T.nib {
      self.registerNib(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    } else {
      self.registerClass(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
    }
  }

  func dequeueReusableSupplementaryView<T: UICollectionViewCell where T: Reusable>(elementKind: String, indexPath: NSIndexPath) -> T {
    return self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: T.reuseIdentifier, forIndexPath: indexPath) as! T
  }
}
