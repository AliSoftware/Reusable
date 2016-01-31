# CHANGELOG

## 2.1.0

* Added support for direct instantiation of arbitrary `UIView` from a nib.  
  [@jakubvano](https://github.com/jakubvano), [#5](https://github.com/AliSoftware/Reusable/pull/5)

There is now a dedicated `NibLoadable` protocol which can be used on any arbitrary `UIView` (even non-"reusable" views) to load it from a XIB (via the `loadFromNib()` function injected via the protocol extension).

_The `NibReusable` protocol still exists for reusable cells but is now declared just as a combination of both the `Reusable` and `NibLoadable` protocols.

## 2.0.0

* Fixed missing `public` visibility for the protocols and extensions
* Improved README documentation

## 1.1.0

* Added documentation
* Fixed generic constraints on the API working with `UICollectionView`'s `SupplementaryView`
* Updated Example project to add an UICollectionView with cells from XIB & Code + Header views

## 1.0.0

* Split protocol in two: `Reusable` and `NibReusable`
* Now contains a Demo project

## 0.1.0

Initial version. Only one `Reusable` protocol
No demo project, but has a `podspec` and a `Package.swift`
