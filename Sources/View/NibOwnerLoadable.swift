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
///  * this class is used as the XIB's File's Owner
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibOwnerLoadable: class {
  /// The nib file to use to load a new instance of the View designed in a XIB
  static var nib: UINib { get }
}

// MARK: Default implementation

public extension NibOwnerLoadable {
  /// By default, use the nib which have the same name as the name of the class,
  /// and located in the bundle of that class
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
}

// MARK: Support for instantiation from NIB

public extension NibOwnerLoadable where Self: UIView {
  /**
   Adds content loaded from the nib to the end of the receiver's list of subviews and adds constraints automatically.
   */
  func loadNibContent() {
    let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
    for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
      view.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(view)
      NSLayoutConstraint.activate(layoutAttributes.map { attribute in
        NSLayoutConstraint(
          item: view, attribute: attribute,
          relatedBy: .equal,
          toItem: self, attribute: attribute,
          multiplier: 1, constant: 0.0
        )
      })
    }
  }
}
#endif

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSLayoutConstraint {
  typealias Attribute = NSLayoutAttribute
}
#endif
