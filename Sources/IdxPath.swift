/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

import Foundation

/// Temporary alias for Foundation.IndexPath type to aid support of both Swift 2 & 3.
#if swift(>=3.0)
  public typealias IdxPath = IndexPath
#else
  public typealias IdxPath = NSIndexPath
#endif
