#
# Rakefile
# Reusable
#
# Example usage:
#
# - rake ci:carthage
# - rake ci:lintpod
# - rake ci:xcodebuild
# - SWIFT_VERSION=2.3 rake ci:xcodebuild
#

def run(command)
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "ci" do
  desc "Builds the Reusable framework using Carthage"
  task :carthage do |t|
    run "carthage build --no-skip-current --verbose"
  end

  desc "Lints the Reusable Podspec"
  task :lintpod do |t|
    swift_version = ENV["SWIFT_VERSION"] ||= "3.0"
    File.open(".swift-version", 'w') { |file| file.puts swift_version }
    run "pod lib lint --verbose --allow-warnings"
  end

  desc "Builds the ReusableDemo project using xcodebuild"
  task :build do |t, args|
    destination = ENV["DESTINATION"] ||= "platform=iOS Simulator,name=iPhone 6,OS=latest"
    run "set -o pipefail && xcodebuild build -workspace Example/ReusableDemo.xcworkspace -scheme ReusableDemo -sdk iphonesimulator -destination='#{destination}' ONLY_ACTIVE_ARCH=NO | xcpretty"
  end

  desc "Tests the ReusableDemo project using xcodebuild"
  task :test do |t, args|
    destination = ENV["DESTINATION"] ||= "platform=iOS Simulator,name=iPhone 6,OS=latest"
    run "set -o pipefail && xcodebuild test -workspace Example/ReusableDemo.xcworkspace -scheme ReusableDemo -sdk iphonesimulator -destination='#{destination}' ONLY_ACTIVE_ARCH=NO | xcpretty"
  end
end
