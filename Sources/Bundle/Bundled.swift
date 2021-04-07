/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2021 AliSoftware
 *
 *********************************************/

import Foundation

/// A few of the protocols'  (i.e. `StoryboardBased`, `NibLoadable` and `NibOwnerLoadable`  described below) default
/// implementations attempt to load resources from the bundle containing the resource.
/// It does this through the `Bundled` protocol. Each time you declare conformance to
/// `StoryboardBased`, `NibLoadable` or `NibOwnerLoadable`, you will have
/// to provide access to the appropriate bundle.
///
/// This can be achieved through one of the following methods...
/// 1) Declare your `Reusable` based classes to conform to `BundledSelf`
/// 2) Declare your `Reusable` based classes to conform to `BundledModule`
/// 3) Provide you own implementation of the `static var bundle: Bundle` property directly

public protocol Bundled {
    static var bundle: Bundle { get }
}
