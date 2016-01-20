# Reusable

![Reusable](Example/ReusableDemo/Assets.xcassets/AppIcon.appiconset/AppIcon-167.png)

A Swift mixin to use `UITableViewCells` and `UICollectionViewCells` in a **type-safe way**, without the need to manipulate their `String`-typed `reuseIdentifiers`.

[![Platform](http://cocoapod-badges.herokuapp.com/p/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)
[![Version](http://cocoapod-badges.herokuapp.com/v/Reusable/badge.png)](http://cocoadocs.org/docsets/Reusable)

For more information on how this works, see [my blog post about this technique](http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/).

# Example usage

First, declare your cells as either `Reusable` or `NibReusable` depending on if they use a `XIB` file when registering.

```swift
class CodeBasedCustomCell: UITableViewCell, Reusable {
  // By default this cell will have a reuseIdentifier or "MyCustomCell"
  // unless you provide an alternative implementation of `var reuseIdentifier`
  // ...
}

class NibBasedCustomCell: UITableViewCell, NibReusable {
  // Here we provide a nib for this cell class
  // (which, if we don't override the protocol's default implementation of `nib`,
  // will use a XIB of the same name as the class)
  // ...
}
```

Then in your `UIViewControllerDataSource`:

```swift
class MyTableViewController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerReusableCell(CodeBasedCustomCell) // This will register using the class without using a UINib
    tableView.registerReusableCell(NibBasedCustomCell) // This will register using NibBasedCustomCell.xib
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    if indexPath.section == 0 {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as CodeBasedCustomCell
    } else {
      cell = tableView.dequeueReusableCell(indexPath: indexPath) as NibBasedCustomCell
    }
    return cell
  }
}
```

# License

This code is distributed under the MIT license. See the `LICENSE` file for more info.
