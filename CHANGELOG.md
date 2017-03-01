# CHANGELOG

## Master

* Fix typo in StoryboardBased examples.  
  [@danshevluk](https://github.com/danshevluk)
  [#42](https://github.com/AliSoftware/Reusable/pull/42)

* Updated README instructions to Swift 3.  
  [@neilkimmett](https://github.com/neilkimmett)
  [#41](https://github.com/AliSoftware/Reusable/pull/41)

## 4.0.1

* Added a tvOS target in the Example project.
* Carthage should now see the tvOS framework

## 4.0.0

### Breaking changes

* The method `static func loadFromNib(owner:)` of `NibOwnerLoadable` has been replaced by instance method `func loadNibContent()`.  
  This is more consistent as we need an instance (owner) anyway, and also avoids possible crashes when used with `UIView` subclasses
  not implementing non-required initializers `init()`/`init(frame:)`.
  _(Method `static func loadFromNib()` of `NibLoadable` is still unchanged)_.  
  [@Skoti](https://github.com/Skoti)
  [#40](https://github.com/AliSoftware/Reusable/pull/40)
* The `storyboard` property of `StoryboardBased` and `StoryboardSceneBased` protocols has been renamed to `sceneStoryboard` to avoid conflicts.  
  [@jakubgert](https://github.com/jakubgert)
  [#33](https://github.com/AliSoftware/Reusable/pull/33)

### Fixes

* Fixing documentation typos for `CollectionHeaderView` and `MyXIBIndexSquaceCell`.  
  [@Skoti](https://github.com/Skoti)

* Fixing TableView Controller scene in Example project, to display cells above `UITabBar`.  
  [@Skoti](https://github.com/Skoti)

## 3.0.1

### Bug Fixes

* Fix `instantiate()` implementation on `StoryboardSceneBased` ViewControllers.  
  [@jakubgert](https://github.com/jakubgert)
  [#38](https://github.com/AliSoftware/Reusable/pull/38)
* Removed strict `NibReusable` protocol conforming in `register` functions.  
  You can now make a `Reusable`-only cell with a `NibLoadable` subclass.  
  [@nekrich](https://github.com/nekrich)
  [#37](https://github.com/AliSoftware/Reusable/pull/37)

## 3.0.0

### Breaking Changes

* Converted library and Demo project to Swift 3.  
    ⚠️ The following methods have new signatures:  
    - `dequeueReusableCell(indexPath:)` is now `dequeueReusableCell(for:)`  
    - `dequeueReusableCell(indexPath:cellType:)` is now `dequeueReusableCell(for:cellType:)`   
    - `registerReusableCell(_:)` is now `register(cellType:)`
    - `registerReusableHeaderFooterView(_:)` is now `register(headerFooterViewType:)`
    - `registerReusableSupplementaryView(_:viewType:)` is now `register(supplementaryViewType:ofKind:)`
    - `dequeueReusableSupplementaryView(_:indexPath:viewType:)` is now `dequeueReusableSupplementaryView(ofKind:for:viewType:)`  
  [@phatblat](https://github.com/phatblat)
  [#30](https://github.com/AliSoftware/Reusable/pull/30)  
  [@ceyhuno](https://github.com/ceyhuno)
  [#31](https://github.com/AliSoftware/Reusable/pull/31)

## 2.5.1

* Adapted source files and demo project for Swift 2.3  
  [@antondomashnev](https://github.com/Antondomashnev)
  [#16](https://github.com/AliSoftware/Reusable/pull/28)

## 2.5.0

* Added the possibility for `NibOwnerLoadable` confirming custom views to pass an existing instance as `owner`
  (used as the File's Owner) in case one already exists. This is especially useful to implement `init(coder:)`
  to load the content of the XIB as subviews of `self` after initialization. See `MyCustomWidget.swift` for an example.  
  [@AliSoftware](https://github.com/AliSoftware)

## 2.4.0

* Added `StoryboardBased` and `StoryboardSceneBased` protocols for storyboard based `UIViewController` easy instantiation.  
  [@AliSoftware](https://github.com/AliSoftware)

## 2.3.0

* Added ` NibOwnerLoadable` protocol for `UIView` set as XIB's File's Owner.  
  [@PoissonBallon](https://github.com/PoissonBallon)
  [#16](https://github.com/AliSoftware/Reusable/pull/16)

_While the `NibLoadable` protocol is adapted to views loaded from XIB but that are set as the root view of the XIB,
this new `NibOwnerLoadable` protocol is adapted to view loaded from XIB too, but that are set as the XIB's File's Owner._

## 2.2.1

* Fixed issue with `register…` methods registering the superclass `T` instead of the dynamic class `cellType` / `viewType`.  
  [@narirou](https://github.com/narirou)
  [#13](https://github.com/AliSoftware/Reusable/pull/13)

## 2.2.0

* Added optional `viewType` & `cellType` parameters to the dequeue functions.  
  [@k3zi](https://github.com/k3zi)
  [#11](https://github.com/AliSoftware/Reusable/pull/11)

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
  [@AliSoftware](https://github.com/AliSoftware)
  [#6](https://github.com/AliSoftware/Reusable/issues/6)

* Fixed bundle location of nibs. By default, `nib: UINib` of `NibLoadable` protocol will now use the nib located in the bundle of the conforming class.  
  [@chrisamanse](https://github.com/chrisamanse)
  [#10](https://github.com/AliSoftware/Reusable/pull/10)

* Fixed issue with subclasses of types conforming to `Reusable` — due to the [Swift bug SR-617](https://bugs.swift.org/browse/SR-617).  
  [@chrisamanse](https://github.com/chrisamanse)
  [#2](https://github.com/AliSoftware/Reusable/issues/2)

## 2.1.0

* Added support for direct instantiation of arbitrary `UIView` from a nib.  
  [@jakubvano](https://github.com/jakubvano)
  [#5](https://github.com/AliSoftware/Reusable/pull/5)

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
