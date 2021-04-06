/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2021 AliSoftware
 *
 *********************************************/

import Foundation

/// Declare your `Reusable` based classes to conform to `BundledSelf`.
/// This provides a default implementation that uses the bundle associated with the class (`Bundle(for: self)`).
/// In previous versions of the framework this was the default for Cocoapod frameworks or main app bundles.
///
/// Exanple:
/// ```
/// final class CustomCell: UITableViewCell, Reusable, BundledSelf { ... And that's it!.. }
/// ```

public protocol BundledSelf: AnyObject, Bundled {
    static var bundle: Bundle { get }
}

public extension BundledSelf {
    static var bundle: Bundle {
        Bundle(for: self)
    }
}
