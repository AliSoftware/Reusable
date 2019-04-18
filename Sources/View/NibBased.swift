//
//  NibBased.swift
//  Reusable
//
//  This code is under the MIT License (MIT)
//
//  Created by Felipe Silva on 17/04/19.
//  Copyright © 2019 Felipe Silva . All rights reserved.
//

import UIKit

/// Make your UIViewController subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's File's Owner
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibBased: class {
    /// The nibName to use to load a new instance of the UIViewController designed in a XIB
    static var nibName: String { get }
}

// MARK: Default implementation

public extension NibBased {
    /// The nibName to use to load a new instance of the UIViewController designed in a XIB,
    /// By default, the nib have the same name as the name of the class
    static var nibName: String {
        return String(describing: self)
    }
}

// MARK: Support for instantiation from NIB

public extension NibBased where Self: UIViewController {
    /**
     Returns a `UIViewController` object instantiated from nib as the XIB's File's Owner
     
     - returns: A `NibBased`, `UIViewController` instance
     */
    static func instantiate() -> Self {
        return Self.init(nibName: self.nibName, bundle: Bundle(for: self))
    }
}
