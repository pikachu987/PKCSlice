#
# Be sure to run `pod lib lint PKCSlice.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PKCSlice'
  s.version          = '0.1.0'
  s.summary          = 'PKCSlice Slice View'
  s.description      = 'Slice View. Input image, color, view'
  s.homepage         = 'https://github.com/pikachu987/PKCSlice'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pikachu987' => 'pikachu77769@gmail.com' }
  s.source           = { :git => 'https://github.com/pikachu987/PKCSlice.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'PKCSlice/Classes/**/*'
end
