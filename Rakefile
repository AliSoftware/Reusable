#
# Rakefile
# Reusable
#

def run(command)
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "ci" do
  desc "Builds the Reusable framework using Carthage"
  task :carthage do |t|
    run "carthage build --no-skip-current --verbose"
  end

  desc "Builds the ReusableDemo project using xcodebuild 7"
  task :xcodebuild do |t|
    run "set -o pipefail && xcodebuild build -workspace Example/ReusableDemo.xcworkspace -scheme ReusableDemo -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3' ONLY_ACTIVE_ARCH=NO | xcpretty"
  end

  desc "Lints the Reusable.podspec"
  task :lintpod do |t|
    run "pod lib lint --verbose"
  end
end
