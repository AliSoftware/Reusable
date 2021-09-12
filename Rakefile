#!/usr/bin/rake

DESTINATIONS = {
  :ios_sim => "OS=14.5,name=iPhone 11,platform=iOS Simulator",
  :tvos_sim => "OS=14.5,name=Apple TV,platform=tvOS Simulator",
}
SWIFTLINT_VERSION = '0.44.0'

## UTILS ##

def run(command, xcpretty: true)
  if xcpretty && system('xcpretty --version >/dev/null') 
    sh "set -o pipefail && #{command} | xcpretty -c"
  else
    sh command
  end
end

def xcodebuild(scheme: '', sdk: '', destination: '', action: 'build')
  run %Q(xcodebuild -workspace Example/ReusableDemo.xcworkspace -scheme "#{scheme}" -sdk #{sdk} -destination="#{destination}" ONLY_ACTIVE_ARCH=NO #{action})
end

def install_pkg(pkg_url)
  tmppath = '/tmp/' + File.basename(pkg_url)
  sh("curl -Lo #{tmppath} #{pkg_url}")
  sh("sudo installer -pkg #{tmppath} -target /")
end

## TASKS ##

namespace :carthage do
  desc "Install Carthage from pkg"
  task :install do
    next if system('which carthage >/dev/null')
    install_pkg('https://github.com/Carthage/Carthage/releases/download/0.33.0/Carthage.pkg')
  end

  desc "Builds the Reusable framework using Carthage"
  task :build do
    run "carthage build --no-skip-current --verbose"
  end
end

namespace :demo do
  desc "Builds the ReusableDemo app for iOS using xcodebuild."
  task :ios do |t, args|
    xcodebuild(scheme: 'ReusableDemo iOS', sdk: 'iphonesimulator', destination: DESTINATIONS[:ios_sim])
  end

  desc "Builds the ReusableDemo app for tvOS using xcodebuild."
  task :tvos do |t, args|
    xcodebuild(scheme: 'ReusableDemo tvOS', sdk: 'appletvsimulator', destination: DESTINATIONS[:tvos_sim])
  end
end

namespace :fmk do
  desc "Builds the Reusable framework for iOS using xcodebuild."
  task :ios do |t, args|
    xcodebuild(scheme: 'Reusable-iOS', sdk: 'iphonesimulator', destination: DESTINATIONS[:ios_sim])
  end

  desc "Builds the Reusable framework for tvOS using xcodebuild."
  task :tvos do |t, args|
    xcodebuild(scheme: 'Reusable-tvOS', sdk: 'appletvsimulator', destination: DESTINATIONS[:tvos_sim])
  end
end

namespace :pod do
  desc "Lints the Reusable.podspec"
  task :lint do |t|
    run("pod lib lint --allow-warnings --quick", xcpretty: false)
  end
end

namespace :spm do
  desc 'Build using SPM'
  task :build do |task|
    puts '*** Compile using SPM ***'
    sh 'xcrun swift build'
  end
end

namespace :swiftlint do
  desc "Install SwiftLint from pkg"
  task :install do
    next if system('which swiftlint >/dev/null') && Gem::Version.new(`swiftlint version`.chomp) >= Gem::Version.new(SWIFTLINT_VERSION)
    install_pkg("https://github.com/realm/SwiftLint/releases/download/#{SWIFTLINT_VERSION}/SwiftLint.pkg")
  end

  desc "Run SwiftLint on the source code"
  task :run => :install do
    run('swiftlint lint --strict', xcpretty: false)
  end
end

# TODO: "namespace :test" once we have Unit Tests
