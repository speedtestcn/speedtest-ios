#
#  Be sure to run `pod spec lint SpeedGameSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name                 = "SpeedGameSDK"
  spec.version              = "1.0.1"
  spec.summary              = "SpeedGameSDK 测速网游戏测速SDK"
  spec.description          = "测速网（SpeedTest.cn）提供网速测试, 网络质量检测, 5G测速, IPv6测速, 带宽检测, Wi-Fi测速, 宽带提速, 网络加速, 内网测速, 游戏测速, 直播测速, 物联网监测, 网站监测, API监测, Ping测试, 路由测试等专业服务, 拥有国内外大量高性能测试点, 覆盖电信, 移动, 联通, 网通, 广电, 长城宽带, 鹏博士等运营商。"
  spec.homepage             = "https://www.speedtest.cn/"
  spec.license              = { :type => "Commercial", :text => "Copyright (C) 2007-2022 speedtest.cn. All rights reserved."}
  spec.author               = "speedtestcn"
  spec.platform             = :ios, "10.0"
  spec.swift_version        = '5.0'
  spec.static_framework     = true
  spec.xcconfig             = { 'ENABLE_BITCODE' => 'NO' }
  spec.source               = { :http => "https://file2.speedtest.cn/v3/2022-03-09/211418704.zip" }
  valid_archs               = ['x86_64', 'arm64']
  spec.frameworks           = 'UIKit'
  spec.vendored_frameworks  = "speedgamesdk/GameSDK.framework"
  spec.resource             = 'speedgamesdk/GameComboSDK.bundle'
  spec.dependency 'Reachability', '~> 3.2'
  spec.dependency 'SimplePingTest', '~> 1.2.0'
  spec.dependency 'JQCommonSDK'
  spec.dependency 'CryptoSwift'

  spec.pod_target_xcconfig  = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
