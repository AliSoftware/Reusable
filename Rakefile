#
# Rakefile
# Reusable
#
# Argument passing in zsh:
# - rake ci:xcodebuild\[8\]
# - rake 'ci:xcodebuild[8]'
# - unsetopt nomatch && rake ci:xcodebuild[8]
# https://robots.thoughtbot.com/how-to-use-arguments-in-a-rake-task
#

def run(command)
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "ci" do
  desc "Builds the Reusable framework using Carthage"
  task :carthage do |t|
    run "carthage build --no-skip-current --verbose"
  end

  desc "Builds the ReusableDemo project using xcodebuild. Pass integer argument to select version (default: 7)"
  task :xcodebuild, [:version] do |t, args|
    version = args[:version] ||= 7
    puts "xcodebuild version: #{version}"
    if version.to_i >= 8
      destination = "-destination 'platform=iOS Simulator,name=iPhone 6,OS=10.0'"
    else
      destination = "-destination 'platform=iOS Simulator,name=iPhone 6,OS=9.3'"
    end
    run "set -o pipefail && xcodebuild build -workspace Example/ReusableDemo.xcworkspace -scheme ReusableDemo -sdk iphonesimulator #{destination} ONLY_ACTIVE_ARCH=NO | xcpretty"
  end

  desc "Lints the Reusable.podspec"
  task :lintpod do |t|
    run "pod lib lint --verbose --allow-warnings"
  end
end
