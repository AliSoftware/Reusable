# Reusable

![Reusable](Example/ReusableDemo/Assets.xcassets/AppIcon.appiconset/AppIcon-167.png)

A Swift mixin to use `UITableViewCells`, `UICollectionViewCells` and `UIViewControllers` in a **type-safe way**, without the need to manipulate their `String`-typed `reuseIdentifiers`. This library also supports arbitrary `UIView` to be loaded via a XIB using a simple call to `loadFromNib()`

[![Platform](http://cocoapod-badges.herokuapp.com/p/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)
[![Version](http://cocoapod-badges.herokuapp.com/v/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)

## Quick Start

### Type-safe `UITableViewCell` and `UICollectionViewCell`

* Mark your `UITableViewCell` classes to conform to either `Reusable` or `NibReusable` (no additional code to implement!)
* Then simply use `tableView.dequeueReusableCell(indexPath: indexPath) as MyCustomCell` to get a dequeued instance of the expected cell class. **No need for you to manipulate `reuseIdentifiers` manually!**
* Use the same for `UICollectionViewCells`

```swift
class MyCustomCell: UITableViewCell, NibReusable { }
…
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  let cell: MyCustomCell = tableView.dequeueReusableCell(indexPath: indexPath)
  … // configure the cell, which is already of the expected MyCustomCell type
  return cell
}
```

No more force-casting the returned `UITableViewCell` instance down to your `MyCustomCell` class, and no more fear that you'll mismatch the `reuseIdentifier` and the class you down-cast to. Now all you have is **a beautiful code and type-safe cells**!

> For more information on how this works, see [my dedicated blog post about this technique](http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/).

### Type-safe `UIView` from XIB

* Mark your `UIView` custom classes to conform to `NibLoadable` (no additional code to implement!)
* Then simply use `MyCustomView.loadFromNib()` to create an instance of that XIB-based view

### Type-safe `UIViewController` from Storyboards

* Mark your `UIViewController` custom classes to conform to `StoryboardBased` (if they are the initial ViewController) or `StoryboardSceneBased` (if they're not)
* Then imply use `YourCustomViewController.instantiate()` to create an instance of that Storyboard-based ViewController.

## Declaring your cell subclasses

First, declare your cells to conform to:

* the `Reusable` protocol if they don't depend on a NIB (this will use `registerClass(…)` to register the cell)
* the `NibReusable` protocol if they use a `XIB` file for their content (this will use `registerNib(…)` to register the cell)

### Example with custom `UITableViewCell` subclasses

So for example to create a `UITableViewCell` subclass which doesn't use a XIB (either because it is only created via code, or because it will be registered automatically via a storyboard):

```swift
class CodeBasedCustomCell: UITableViewCell, Reusable {
  // By default this cell will have a reuseIdentifier of "CodeBasedCustomCell"
  // unless you provide an alternative implementation of `var reuseIdentifier`
  
  // No need to add anything to conform to Reusable. you can just keep your normal cell code
  @IBOutlet private weak var label: UILabel!
  func fillWithText(text: String?) { label.text = text }
}
```

And to create a `UITableViewCell` subclass whose content is based on a `XIB`:

```swift
class NibBasedCustomCell: UITableViewCell, NibReusable {
  // Here we provide a nib for this cell class (which, if we don't override the protocol's
  // default implementation of `nib`, will use a XIB of the same name as the class)
  
  // No need to add anything to conform to Reusable. you can just keep your normal cell code
  @IBOutlet private weak var pictureView: UIImageView!
  func fillWithImage(image: UIImage?) { pictureView.image = image }
}
```

> If you create a XIB-based cell, don't forget to set its _Reuse Identifier_ field in Interface Builder to the same string as the name of the cell class itself.

### Example with custom  `UICollectionViewCell` subclasses

This works exactly the same as `UITableViewCell`.

So for a Code-based `UICollectionViewCell` subclass:

```swift
// A UICollectionViewCell which doesn't need a XIB to register
// Either because it's all-code, or because it's registered via Storyboard
class CodeBasedCollectionViewCell: UICollectionViewCell, Reusable {
  // The rest of the cell code goes here
}
```

And for a XIB-based `UICollectionViewCell` subclass:

```swift
// A UICollectionViewCell using a XIB to define it's UI
// And that will need to register using that XIB
class NibBasedCollectionViewCell: UICollectionViewCell, NibReusable {
  // The rest of the cell code goes here
}
```

### Example with a XIB-based arbitrary UIView

`Reusable` can also be used to load an arbitrary `UIView` subclass (even a non-reusable, non-cell view) designed in a XIB by simply marking it as `NibLoadable`:

```swift
class NibBasedRandomView: UIView, NibLoadable {
  // The rest of the view code goes here
}
```

### Example with a UIView in XIB's File's Owner

`Reusable` can also be used to load a `UIView` in Xib's File's Owner (even a non-reusable, non-cell view) designed in a XIB by simply marking it as `NibOwnerLoadable`:

```swift
class NibBasedRandomView: UIView, NibOwnerLoadable {
  // The rest of the view code goes here
}
```

## Registering your cells by code

Then to use those cells, you'll register them like this, without the need to manipulate any `reuseIdentifier` anywhere in the code:

```swift
class MyViewController: UIViewController {
  @IBOutlet private weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerReusableCell(CodeBasedCustomCell) // This will register using the class without using a UINib
    tableView.registerReusableCell(NibBasedCustomCell) // This will register using NibBasedCustomCell.xib
  }
}
```

> Note: If your cell is prototyped in a Storyboard, there is no need to call `registerReusableCell` for those cell prototypes, as the Storyboard auto-register these cell prototypes with the `UITableView` / `UICollectionView` they are prototyped into.

## Dequeuing your cells

Then in your implementation of `UIViewControllerDataSource`, especially to dequeue a cell you will be able to do:

```swift
extension MyViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(indexPath: indexPath) as CodeBasedCustomCell
      // Customize the cell here. You can call any type-specific methods here without the need for type-casting
      cell.fillWithText("Foo")
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(indexPath: indexPath) as NibBasedCustomCell
      // Customize the cell here. no need to downcasting here either!
      cell.fillWithImage(UIImage(named:"Bar"))
      return cell
    }
  }
}
```

## Instantiating arbitrary views from XIBs

If you mark an arbitrary (non-cell) `UIView` as `NibLoadable` [as demonstrated above](#example-with-a-xib-based-arbitrary-uiview), you can also instantiate such a view using its Nib by calling `loadFromNib()`:

```swift
let instance1 = NibBasedRandomView.loadFromNib()
let instance2 = NibBasedRandomView.loadFromNib()
let instance3 = NibBasedRandomView.loadFromNib()
…
```

## Instanciating ViewControllers from Storyboards 

### Initial ViewController

If one of your custom `UIViewController` (named `CustomVC` for example) is **designed as the initial ViewController of a Storyboard** (named `CustomVC.storyboard`):

* simply mark it as conforming to `StoryboardBased`
* call `instantiate()` to create an instance from the Storyboard

```swift
final class CustomVC: UIViewController: StoryboardBased { }
…
func presentIt() {
  let vc = CustomVC.instantitate()
  self.presentViewController(vc, animated: true) {}
}
```

### Secondary ViewControllers

If your custom `UIViewController` (named `SecondaryVC` for example) is **designed in a Storyboard `CustomVC.storyboard` but is _not_ the initial ViewController**, but instead has a custom **"Scene Identifier"** with the value `SecondaryVC` to be reached:

* mark it as conforming to `StoryboardSceneBased`
* define `static let storyboard = …` to indicate the Storyboard where this scene is designed
* call `instantiate()` to create an instance from the Storyboard

_(If you don't implement `static var sceneIdentifier`, it will assume the Scene to have the name of the class used as its scene identifier)_

```swift
final class SecondaryVC: UIViewController: StoryboardSceneBased {
  static let storyboard = UIStoryboard(name: "CustomVC", bundle: nil)
}
…
func presentIt() {
  let vc = SecondaryVC.instantitate() // Init from the "SecondaryVC" scene of CustomVC.storyboard
  self.presentViewController(vc, animated: true) {}
}
```

## Tip: make your subclasses `final`

It's strongly advised to mark your custom `UITableViewCell`, `UICollectionViewCell`, `UIView` and `UIViewController` subclasses as being `final`, because:

* usually your custom cells and VCs are not intended to be subclassed
* more importantly, it helps the compiler a lot and gives you big optimizations
* it can be required in some cases when conforming to `protocols` that have `Self` requirements, like the ones used by this pod (`Reusable`, `StoryboardBased`, …). 

In some cases you can avoid making your classes `final`, but in general it's a good practice, and in the case of this pod, usually your custom `UIViewController` or whatever won't be subclassed anyway:

* Either they are intended to be used and instantiated directly and never be subclassed, so `final` makes sense here
* In case your custom `UIViewController`, `UITableViewCell`, etc… is intended to be subclassed and be the parent class of many classes in your app, it makes more sense to add the protocol conformance (`StoryboardBased`, `Reusable`, …) to the child classes (and mark _them_ `final`) than adding the protocol on the parent, abstract class.

## Customization

`Reusable`, `NibLoadable` and `NibReusable` are what is usually called [Mixins](http://alisoftware.github.io/swift/protocol/2015/11/08/mixins-over-inheritance/), which basically is a Swift protocol with a default implementation provided for all of its methods. The main benefit is that **you don't need to add any code**: just conform to `Reusable`, `NibLoadable` or `NibReusable` and you're ready to go.

But of course, those provided implementations are just _default implementations_. That means that if you need **you can still provide your own implementations** in case for some reason some of your cells don't follow the classic configuration of using the same name for both the class, the `reuseIdentifier` and the XIB file.

```swift
class VeryCustomNibBasedCell: UITableViewCell, NibReusable {
  // This cell use a non-standard configuration: its reuseIdentifier and XIB file
  // have a different name as the class itself. So we need to provide a custom implementation or `NibReusable`
  static var reuseIdentifier: String { return "VeryCustomReuseIdentifier" }
  static var nib: UINib { return UINib(nibName: "VeryCustomUI", bundle: nil) } // Use VeryCustomUI.xib
  
  // Then continue with the rest of your normal cell code 
}
```

## Advantages of using Reusable

Note how, in the examples above and when using `Reusable`:

* You never have to use a String-typed `reuseIdentifier` in your code anywhere
* The **proper cell type to dequeue is infered by Swift from the return type**

  * The simple fact that we wrote `dequeueReusableCell(…) as MyCellType` let the Swift compiler infer that you expect a `MyCellType` and deduce the `reuseIdentifier` to use for that all by itself! ✨

* The code is type-safe, as the `dequeueReusableCell(…)` function will return the type you asked — and not the `UITableViewCell` non-specific superclass as with Apple APIs

  * This way you can call methods even specific to your `MyCellType` return type on that cell next, without the need to cast it!

For more information and explanations on this code, see [my detailed blog post about this here](http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/).


## Example Project

This repository comes with an example project in the `Example/` folder. Feel free to try it.

It demonstrate how `Reusable` work:

* both for `UITableViewCell` and `UICollectionViewCell` subclasses,
* both for cells whose UI template is either only provided by plain code, or provided by a XIB, or prototyped directly in a Storyboard.
* both for cells `UICollectionView`'s `SupplementaryViews` (section Headers)

## License

This code is distributed under the MIT license. See the `LICENSE` file for more info.
