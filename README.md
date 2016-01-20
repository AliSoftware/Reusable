# Reusable

![Reusable](Example/ReusableDemo/Assets.xcassets/AppIcon.appiconset/AppIcon-167.png)

A Swift mixin to use `UITableViewCells` and `UICollectionViewCells` in a **type-safe way**, without the need to manipulate their `String`-typed `reuseIdentifiers`.

[![Platform](http://cocoapod-badges.herokuapp.com/p/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)
[![Version](http://cocoapod-badges.herokuapp.com/v/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)

For more information on how this works, see [my blog post about this technique](http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/).

## Declaring your cell subclasses

First, declare your cells to conform to:

* the `Reusable` protocol if they don't depend on a NIB (this will use `registerClass(…)` to register the cell)
* the `NibReusable` protocol if they use a `XIB` file for their content (this will use `registerNib(…)` to register the cell)

So for example to create a `UITableViewCell` subclass which doesn't use a XIB (either because it is only created via code, or because it will be registered automatically via a storyboard):

```swift
class CodeBasedCustomCell: UITableViewCell, Reusable {
  // By default this cell will have a reuseIdentifier or "MyCustomCell"
  // unless you provide an alternative implementation of `var reuseIdentifier`
  // ...
}
```

And to create a `UITableViewCell` subclass whose content is based on a `XIB`:

```swift
class NibBasedCustomCell: UITableViewCell, NibReusable {
  // Here we provide a nib for this cell class
  // (which, if we don't override the protocol's default implementation of `nib`,
  // will use a XIB of the same name as the class)
  // ...
}
```

> If you create a XIB-based cell, don't forget to set its _Reuse Identifier_ field in Interface Builder to the same string as the name of the cell class itself.

This works the same for `UICollectionViewCell` subclasses of course:

### Code-based cell:

```swift
// A UICollectionViewCell which doesn't need a XIB to register
// Either because it's all-code, or because it's registered via Storyboard
class CodeBasedCollectionViewCell: UICollectionViewCell, Reusable {
  // ...
}
```

### XIB-based cell:

```swift
// A UICollectionViewCell using a XIB to define it's UI
// And that will need to register using that XIB
class NibBasedCollectionViewCell: UICollectionViewCell, NibReusable {
  // The normal cell code goes here
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
      // Customize the cell here. You can call any type-specific methods here
      // without the need for type-casting, as cell is a CodeBasedCustomCell,
      // not a generic UITableViewCell!
      cell.fillCodeBasedCellWithValue(…)
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(indexPath: indexPath) as NibBasedCustomCell
      // Customize the cell here. In this case, `cell` is of the specific
      // type NibBasedCustomCell so no need to downcast here either!
      return cell
    }
  }
}
```

## Advantages of using Reusable

Note how, in the examples above and when using `Reusable`:

* You never have to use a String-typed `reuseIdentifier` in your code anywhere
* The **proper cell type to dequeue is infered by Swift from the return type**

  * The simple fact that we wrote `dequeueReusableCell(…) as MyCellType` let the Swift compiler infer that you expect a `MyCellType` and deduce the `reuseIdentifier` to use for that all by itself! ✨

* The code is type-safe, as the `dequeueReusableCell(…)` function will return the type you asked — and not the `UITableViewCell` non-specific superclass

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
