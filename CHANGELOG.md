# CHANGELOG

## 2.2.1

* Fixed issue with `register…` methods registering the superclass `T` instead of the dynamic class `cellType` / `viewType`.  
  [@narirou](https://github.com/narirou), [#13](https://github.com/AliSoftware/Reusable/pull/13)

## 2.2.0

* Added optional `viewType` & `cellType` parameters to the dequeue functions.  
  [@k3zi](https://github.com/k3zi), [#11](https://github.com/AliSoftware/Reusable/pull/11)

This parameter is only needed if you can't write `… as MyCell` (to let Swift infer the cell type from the return type),
which might be the case for example when your cell class is stored in a variable:

```swift
let cellType: Any.Type = self.cellTypeForIndexPath(indexPath)
// Can't do this in this case (because cellType is a variable):
let cell = tableView.dequeueReusableCell(indexPath: indexPath) as cellType ❌ // compiler error
// But now we can use that alternate way for such cases:
let cell = tableView.dequeueReusableCell(indexPath: indexPath, cellType: cellType)
```

But if you know the type at compile time, you can omit the `cellType` parameter and still do this, letting the return type infer it for you:

```swift
let cell = tableView.dequeueReusableCell(indexPath: indexPath) as MyCell
```

## 2.1.1

* Made every method `final` to allow more optimizations.  
  [@AliSoftware](https://github.com/AliSoftware)

* Banned the use of `as!` in the source code in favour of `guard let x = y else { fatalError(…) }`.
  This avoids force-casts (which are considered bad practice) and generate a more explicit fatal error in case the developer forgot something (typically forgot to set the reuseIdentifier in IB).  
  [@AliSoftware](https://github.com/AliSoftware), [#6](https://github.com/AliSoftware/Reusable/issues/6)

* Fixed bundle location of nibs. By default, `nib: UINib` of `NibLoadable` protocol will now use the nib located in the bundle of the conforming class.  
  [@chrisamanse](https://github.com/chrisamanse), [#10](https://github.com/AliSoftware/Reusable/pull/10)

* Fixed issue with subclasses of types conforming to `Reusable` — due to the [Swift bug SR-617](https://bugs.swift.org/browse/SR-617).  
  [@chrisamanse](https://github.com/chrisamanse), [#2](https://github.com/AliSoftware/Reusable/issues/2)

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
