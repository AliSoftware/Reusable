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
///  * this ViewController is not the initialViewController of your Storyboard, but a different scene
///
/// to be able to instantiate them from the Storyboard in a type-safe manner.
///
/// You need to implement `storyboard` yourself to indicate the UIStoryboard this scene is from.
public protocol StoryboardSceneBased: class {
  /// The UIStoryboard to use when we want to instantiate this ViewController
  static var storyboard: UIStoryboard { get }
  /// The scene identifier to use when we want to instantiate this ViewController from its associated Storyboard
  static var sceneIdentifier: String { get }
}

// MARK: Default Implementation

public extension StoryboardSceneBased {
  /// By default, use the `sceneIdentifier` with the same name as the class
  static var sceneIdentifier: String {
    return String(describing: self)
  }
}

// MARK: Support for instantiation from Storyboard

public extension StoryboardSceneBased where Self: UIViewController {
  /**
   Create an instance of the ViewController from its associated Storyboard and the Scene with identifier `sceneIdentifier`

   - returns: instance of the conforming ViewController
   */
  static func instantiate() -> Self {
    let storyboard = (Self.self as StoryboardSceneBased.Type).storyboard
    guard let vc = storyboard.instantiateViewController(withIdentifier: self.sceneIdentifier) as? Self else {
      fatalError("The viewController '\(self.sceneIdentifier)' of '\(storyboard)' is not of class '\(self)'")
    }
    return vc
  }
}
