#
#  Be sure to run `pod spec lint JQCommonSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "JQCommonSDK"
  spec.version      = "1.0.1"
  spec.summary      = "JQCommonSDK 测速网相关SDK使用权限验证库"
  spec.description  = "https://www.speedtest.cn/"
  spec.homepage     = "https://github.com/speedtestcn/speedtest-ios.git"
  spec.license      = { :type => "Commercial", :text => "Copyright (C) 2007-2022 speedtest.cn. All rights reserved."}
  spec.author       = "speedtestcn"
  spec.platform     = :ios, "10.0"
  spec.source       = { :http => "https://file2.speedtest.cn/sdk/ios/1.0.1/speedsdk.zip" }
  valid_archs = ['x86_64', 'arm64']
  spec.frameworks = 'UIKit'

  spec.subspec 'JQCommon' do |ss|
    ss.vendored_frameworks = 'speedsdk/JQCommonSDK.framework'
  end

  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
