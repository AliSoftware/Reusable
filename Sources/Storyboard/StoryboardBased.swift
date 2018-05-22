/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import UIKit

// MARK: Protocol Definition

/// Make your UIViewController subclasses conform to this protocol when:
///  * they *are* Storyboard-based, and
///  * this ViewController is the inside of your Storyboard
///
/// to be able to instanciate multiple viewControllers from the same Storyboard in a type-safe manner
public protocol StoryboardBased where Self: UIViewController {
  /// The UIStoryboard to use when we want to instantiate this ViewController
  static var sceneStoryboard: UIStoryboard { get }
  static var storyboardName: String { get }
}

// MARK: Default Implementation

public extension StoryboardBased {
  /// By default, use the storybaord with the same name as the class
  static var sceneStoryboard: UIStoryboard {
    return UIStoryboard(name: Self.storyboardName, bundle: Bundle(for: self))
  }
  /// By default, the same name as the class
  static var storyboardName: String {
    return String(describing: self)
  }
    
  /**
     Create an instance of the ViewController from its associated Storyboard's initialViewController
     
     - returns: instance of the conforming ViewController
  */
  static func instantiate() -> Self {
    guard let vc = sceneStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
        fatalError("The controller of '\(sceneStoryboard)' is not of class '\(self)'")
    }
    return vc
  }
}
