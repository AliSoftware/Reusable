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

DESTINATIONS = {
  :ios_sim => "OS=9.3,name=iPhone 6,platform=iOS Simulator",
  :tvos_sim => "OS=10.1,name=Apple TV 1080p,platform=tvOS Simulator",
}

## TASKS ##

namespace :carthage do
  desc "Builds the Reusable framework using Carthage"
  task :build do |t|
    run "carthage build --no-skip-current --verbose"
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

# TODO: "namespace :test" once we have Unit Tests

namespace :pod do
  desc "Lints the Reusable.podspec"
  task :lint do |t|
    run("pod lib lint --allow-warnings --quick", xcpretty: false)
  end
end
