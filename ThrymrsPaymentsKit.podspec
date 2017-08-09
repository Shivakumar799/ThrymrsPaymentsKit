#
# Be sure to run `pod lib lint ThrymrsPaymentsKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ThrymrsPaymentsKit'
  s.version          = '0.1.0'
  s.summary          = 'Description Description Description Description  ThrymrsPaymentsKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Description Description Description Description Description
                       DESC

  s.homepage         = 'https://github.com/Shivakumar799/ThrymrsPaymentsKit.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shivakumar799' => 'shivakumar.muddunuru@thrymr.net' }
  s.source           = { :git => 'https://github.com/Shivakumar799/ThrymrsPaymentsKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ThrymrsPaymentsKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ThrymrsPaymentsKit' => ['ThrymrsPaymentsKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
#s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 2.3','OpenSSL','TFHpple'

end
