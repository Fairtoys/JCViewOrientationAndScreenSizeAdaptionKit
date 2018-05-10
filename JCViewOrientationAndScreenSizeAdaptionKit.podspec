#
# Be sure to run `pod lib lint JCMultipleViewLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JCViewOrientationAndScreenSizeAdaptionKit'
  s.version          = '0.1.0'
  s.summary          = '一个屏幕尺寸和方向适配的工具类，和一个支持屏幕尺寸和方向的弹出工具容器类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '一个屏幕尺寸和方向适配的工具类，和一个支持屏幕尺寸和方向的弹出工具容器类, 用来解决日常开发中遇到的横竖屏问题和布局问题'

  s.homepage         = 'https://github.com/Fairtoys/JCViewOrientationAndScreenSizeAdaptionKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '313574889@qq.com' => '313574889@qq.com' }
  s.source           = { :git => 'https://github.com/Fairtoys/JCViewOrientationAndScreenSizeAdaptionKit.git', :tag => s.version.to_s, :submodules => true }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JCViewOrientationAndScreenSizeAdaptionKit/JCViewOrientationAndScreenSizeAdaptionKit.h'
  #s.source_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/**/*'

  s.public_header_files = 'JCViewOrientationAndScreenSizeAdaptionKit/JCViewOrientationAndScreenSizeAdaptionKit.h'
  s.frameworks = 'UIKit'
  s.dependency 'Masonry' , '~> 1.0.0'
  
  s.subspec 'JCOrientationAndScreenSizeUtils' do |ss|
    ss.source_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCOrientationAndScreenSizeUtils/**/*'
    ss.public_header_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCOrientationAndScreenSizeUtils/**/*.h'
    ss.ios.frameworks = 'UIKit'
  end
  s.subspec 'JCViewMultipleLayout' do |ss|
    ss.source_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCViewMultipleLayout/**/*'
    ss.public_header_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCViewMultipleLayout/**/*.h'
    ss.ios.frameworks = 'UIKit'
    ss.dependency 'JCViewOrientationAndScreenSizeAdaptionKit/JCOrientationAndScreenSizeUtils'
  end
  s.subspec 'JCViewMultipleLayout' do |ss|
    ss.source_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCViewMultipleLayout/**/*'
    ss.public_header_files = 'JCViewOrientationAndScreenSizeAdaptionKit/Classes/JCViewMultipleLayout/**/*.h'
    ss.ios.frameworks = 'UIKit'
    ss.dependency 'JCViewOrientationAndScreenSizeAdaptionKit/JCOrientationAndScreenSizeUtils'
  end



end
