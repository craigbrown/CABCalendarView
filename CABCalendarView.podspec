#
# Be sure to run `pod lib lint CABCalendarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CABCalendarView'
  s.version          = '1.0.0'
  s.summary          = 'An iOS calendar view component with vertical scrolling and auto-layout support.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This calendar view component can be used in an iOS app to easily add a slick and functional calendar. Integrated with Interface Builder for ease of use, and fully compatible with auto-layout, so can automatically resize itself to look good on any device. All the properties are handled by a data-source and delegate, just like a UITableView, so there is barely any learning curve.
                       DESC

  s.homepage         = 'https://github.com/Frakur/CABCalendarView'
  # s.screenshots     = 'https://github.com/Frakur/CABCalendar/raw/master/Screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'craig' => 'craigbrown24+cocoapod@gmail.com' }
  s.source           = { :git => 'https://github.com/Frakur/CABCalendarView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/craigb24'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CABCalendarView/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
