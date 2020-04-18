/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

#if canImport(UIKit)
import UIKit

// MARK: Protocol Definition

/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: class {
  /// The nib file to use to load a new instance of the View designed in a XIB
  static var nib: UINib { get }
}

// MARK: Default implementation

public extension NibLoadable {
  /// By default, use the nib which have the same name as the name of the class,
  /// and located in the bundle of that class
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

// MARK: Support for instantiation from NIB

public extension NibLoadable where Self: UIView {
  /**
   Returns a `UIView` object instantiated from nib
   
   - returns: A `NibLoadable`, `UIView` instance
   */
  static func loadFromNib() -> Self {
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
      fatalError("The nib \(nib) expected its root view to be of type \(self)")
    }
    return view
  }

  func awakeAfterUsingSurrogate() -> Self {
    guard subviews.isEmpty else {
      return self
    }
    let surrogateView = Self.loadFromNib()
    surrogateView.frame = frame
    surrogateView.isHidden = isHidden
    surrogateView.tag = tag
    surrogateView.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
    surrogateView.injectIntoCopiedConstrainst(from: self)
    return surrogateView
  }
}

private extension UIView {

  func injectIntoCopiedConstrainst(from view: UIView) {
    for constraint in view.constraints {
      guard let firstItem = constraint.firstItem === view ? self : constraint.firstItem else { continue }
      let secondItem = constraint.secondItem === view ? self : constraint.secondItem
      let surrogateConstraint = constraint.replacing(firstItem: firstItem, andSecondItem: secondItem)
      self.addConstraint(surrogateConstraint)
    }
  }
}

private extension NSLayoutConstraint {

  func replacing(firstItem: Any, andSecondItem secondItem: Any?) -> NSLayoutConstraint {
    let copy = NSLayoutConstraint(
      item: firstItem, attribute: firstAttribute,
      relatedBy: relation,
      toItem: secondItem, attribute: secondAttribute,
      multiplier: multiplier, constant: constant
    )
    copy.identifier = identifier
    copy.priority = priority
    copy.shouldBeArchived = shouldBeArchived
    return copy
  }
}
#endif
