/*********************************************
 *
 * This code is under the MIT License (MIT)
 *
 * Copyright (c) 2016 AliSoftware
 *
 *********************************************/

#if canImport(UIKit)
import UIKit

public extension UICollectionReusableView {
    static var elementKind: String {
        return String(describing: self)
    }
}

public extension UICollectionViewLayout {
    final func register<T: UICollectionReusableView>(decorationViewType: T.Type)
    where T: Reusable & NibLoadable {
        self.register(decorationViewType.nib, forDecorationViewOfKind: decorationViewType.elementKind)
    }
    
    final func register<T: UICollectionReusableView>(decorationViewType: T.Type)
    where T: Reusable {
        self.register(decorationViewType.self, forDecorationViewOfKind: decorationViewType.elementKind)
    }
}

#endif
