#
# Be sure to run `pod lib lint DDLogg.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DDLogg'
  s.module_name      = "DDBridge"
  s.version          = '0.1.8'
  s.summary          = 'This Frame work is used for act as bridge for DataDog logger'
  s.description      = 'This Frame work is used for act as bridge between Kotlin muliplatform library and Datadog frameworks for Data logging'


  s.homepage         = 'https://github.com/aneeshzed/DDLogg'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aneeshzed' => 'aneesh2405@gmail.com' }
  s.source           = { :git => 'https://github.com/aneeshzed/DDLogg.git', :tag => s.version.to_s }

  s.swift_version      = '5.1'
  s.ios.deployment_target = '11.0'
  s.platform = :ios, '11.0'

  s.source_files = 'DDLogg/Classes/**/*.{h,m,swift}'
  s.public_header_files = 'DDLogg/Classes/**/*.h'
  s.dependency 'DatadogSDKObjc', '~> 1.14'
end
