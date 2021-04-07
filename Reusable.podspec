Pod::Spec.new do |s|
  s.cocoapods_version = '~> 1.4'

  s.name         = "Reusable"
  s.version      = "4.1.1"
  s.summary      = "A Swift Mixin to deal with reusable UITableView & UICollectionView cells and XIB-based views"

  s.description  = <<-DESC
                Reusable is a [Swift Mixin](http://alisoftware.github.io/swift/protocol/2015/11/08/mixins-over-inheritance/)
                to easily deal with your reusable UITableViewCell and UICollectionViewCell classes.

                Simply mark your `UITableViewCell` or `UICollectionViewCell` sublcasses as
                conforming to either `Reusable` or `NibReusable` and you'll be able to
                manipulate them way easier, and without worrying with String-type reuseIdentifiers
                ever again, and instead use them in a type-safe manner!

                Reusable also support marking any arbitrary `UIView` subclass as `NibLoadable` so that
                you can then call `loadFromNib()` on the custom view class easily without adding any code.

                For more info, see [my blog post](http://alisoftware.github.io/swift/generics/2016/01/06/generic-tableviewcells/)
                about this technique.
                   DESC

  s.homepage     = "https://github.com/AliSoftware/Reusable"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Olivier Halligon" => "olivier@halligon.net" }
  s.social_media_url   = "http://twitter.com/aligatr"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/AliSoftware/Reusable.git", :tag => s.version.to_s }
  s.swift_version = '5.0'

  s.subspec 'Bundled' do |ss|
    ss.source_files = "Sources/Bundle/Bundled.swift", "Sources/Bundle/BundledSelf.swift"
  end
  
  s.subspec 'View' do |ss|
    ss.dependency 'Reusable/Bundled'
    ss.source_files  = "Sources/View/*.swift"
  end
  
  s.subspec 'Storyboard' do |ss|
    ss.dependency 'Reusable/Bundled'
    ss.source_files  = "Sources/Storyboard/*.swift"
  end

  s.framework  = "UIKit"

end
