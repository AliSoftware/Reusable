import UIKit

/// Make your UIView subclasses
/// conform to this protocol when they *are* NIB-based
/// to be able to instantiate them from NIB in a type-safe manner
public protocol NibLoadable: class {
  /// The nib file to use to load a new instance of the View designed in a XIB
  static var nib: UINib { get }
}

// MARK: - Default implementation form NibLoadable

public extension NibLoadable {
  /// By default, use the nib which have the same name as the name of the class,
  /// and located in the bundle of that class
  static var nib: UINib {
    return UINib(nibName: String(self), bundle: NSBundle(forClass: self))
  }
}

// MARK: - Support for instantiation from nib

public extension NibLoadable where Self: UIView {
  /**
   Returns a `UIView` object instantiated from nib

   - returns: A `NibLoadable`, `UIView` instance
   */
  static func loadFromNib() -> Self {
    guard let view = nib.instantiateWithOwner(nil, options: nil).first as? Self else {
      fatalError("The nib \(nib) expected its root view to be of type \(self)")
    }
    return view
  }
}
