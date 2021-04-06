/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2021 AliSoftware
 *
 *********************************************/

import Foundation

/// Declaring your `Reusable` based classes to conform to `BundledModule`.
/// This provides a default implementation that uses the bundle associated
///  with a Swift Package Manager Bundle (`Bundle.module`).
///
/// Example:
/// ```
/// final class CustomCell: UITableViewCell, Reusable, BundledModule { ... And that's it! ... }
/// ```
///
/// For the the resource to be loaded from the bundle of your package, you
/// will also need to add the following extension somewhere in your package
/// framework...
///
/// ```
/// public extension BundledModule {
///    static var bundle: Bundle {
///        Bundle.module
///    }
/// }
/// ```

public  protocol BundledModule: AnyObject, Bundled {
}
