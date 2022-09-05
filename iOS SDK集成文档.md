# iOS SDK集成文档

本文为你介绍了iOS端网络测速SDK集成导入方法，帮助你快速集成网络测速SDK并能使用测速基本功能。

## 前提条件

开发前的环境要求如下表所示：

| 类别      | 说明              |
| --------- | ----------------- |
| 系统版本  | iOS 10 及以上版本 |
| Xcode版本 | 12.0 +            |

# 集成SDK

## 下载SDK

1.你需要下载SDK，下载链接请参见[SDK下载](https://b-api.speedtest.cn/sdkVersion/download?sdkName=speedSdk&os=iOS&file=sdk)，解压所有的文件放置在程序的执行路径下，文件类型和路径如下表所示：

| **文件名称**                     | **文件路径**              |
| -------------------------------- | ------------------------- |
| SpeedTestPermissionSDK.framework | *程序的执行路径下         |
| SpeedTestKit.framework           | *程序的执行路径下(接口版) |
| SpeedTestSDK.framework           | *程序的执行路径下(UI版)   |
| SpeedTestResources.bundle        | *程序的执行路径下(UI版)   |

## 项目引入SDK

### \- 手动集成

1. 将下载的"SpeedTestPermissionSDK"framework，"SpeedTestKit"framework直接拖入项目

2. 关闭**Bitcode**

![](https://file2.speedtest.cn/md-img/speedSdkIOS/speed-sdk-iOS-1.png)

### \- CocoaPods集成

暂不支持**CocoaPods**导入方式。

## 第三方引用说明

请在你的项目中添加下列第三方框架：

```ruby
pod 'Reachability', '~> 3.2'
pod 'SimplePingTest', '~> 1.2.0'
pod 'CryptoSwift', '~> 1.5.1'
```

**说明：**集成`CryptoSwift`之后，需要在pod下修改`CryptoSwift`的`Build Libraries for Distribution` 设置修改为`YES`。

## Object-C 项目配置

由于SDK是由**Swift**开发，为了正常使用系统Swift库，请保证项目中至少有一个**swift**文件    
创建**OC**调用Swift头文件，默认文件名为: **xxx-Swift.h** (xxx为你的项目名)。     
使用时，请导入：

```objectivec
#import <SpeedTestPermissionSDK/SpeedTestPermissionSDK-Swift.h>
#import <SpeedTestKit/SpeedTestKit-Swift.h>
```

## 隐私权限

**info.plist**设置，为了更好的分配测速节点，请开通定位权限。

![](https://file2.speedtest.cn/md-img/speedSdkIOS/speed-sdk-iOS-2.png)

因为部分测速节点不支持**HTTPS**请求，请设置允许**非HTTPS**请求
![](https://file2.speedtest.cn/md-img/speedSdkIOS/speed-sdk-iOS-3.png)

**TARGETS**设置，为了获取**WiFi**名称，请添加**Access WiFi Information**。
![](https://file2.speedtest.cn/md-img/speedSdkIOS/speed-sdk-iOS-4.png)

# 功能使用

## 项目引入SDK

```swift
import SpeedTestPermissionSDK 
import SpeedTestKit
```

## SDK初始化

执行初始化需要使用开发者申请应用得到 **appId** 和 **appKey**，初始化代码：

```swift
SpeedTestPermission.registerApp(appId: "你申请的appId", appKey: "你申请的appKey")
```

**appId** 和 **key**是申请的应用的唯一标识，[点击获取](/products/)

# 高级功能

## iOS 接口版

不含有用户操作界面的版本。


### \- 获取全局对象

初始化全局对象，获取speed全局对象。

```swift
let speed = SpeedTestKit()
```

### \- 获取测速节点列表

测速节点列表接口回调，根据节点距离当前位置的距离进行排列，需要定位权限。

测速节点列表接口不支持分页操作，返回包括**节点ID**，**节点名称**，**节点城市**，**节点运营商**的节点数组列表

具体使用见下:

```swift
speed.requestNodeList(withPage: 1) { nodes in
    for node in nodes {
        print("node_id:\(node.node_id)")  // 节点id
        print("sponsor:\(node.sponsor)")  // 节点名称
        print("city:\(node.city)")        // 节点城市
        print("oper:\(node.oper)")        // 节点运营商
    }
} error: { err in
    print("error: ", err)
}
```

### \- 配置测速单位

测速单位为非必须配置项，默认为**Mbps**，可选值：**Mbps**、**KB/s**、**MB/s**，示例代码如下：

```swift
/// 将单位设置为Mbps
speed.speedUnit = .Mbps

/// 将单位设置为KB/s
speed.speedUnit = .KB/s 

/// 将单位设置为MB/s
speed.speedUnit = .MB/s
```

### \- 启用快速测速

开启快速测速后，当测速结果趋于稳定后不再继续测速，测速时长范围**5s-15s**。

| 参数      | 说明     | 类型 | 可选值     | 默认值 |
| --------- | -------- | ---- | ---------- | ------ |
| fastSpeed | 快速测速 | Bool | true/false | false  |

```swift
/// 开启快速测速
speed.fastSpeed = true

/// 关闭快速测速
speed.fastSpeed = false
```

### \- 开始测速

开始测速一共分为四个调用**pingResult**、**speed**、**finish**、**loss**和**busyData**

### pingResult

开始**Ping**，返回**ping**和**jitter**的值

| 参数    | 说明                 | 类型   | 可选值 | 默认值 |
| ------- | -------------------- | ------ | ------ | ------ |
| ping    | 时延（单位ms）       | Int    | -      | 0      |
| jitter  | 抖动（单位ms）       | Double | -      | 0      |
| pingMin | 时延最小值（单位ms） | Int    | -      | 0      |
| pingMax | 时延最大值（单位ms） | Int    | -      | 0      |

**说明：**如果返回的值为`-1`，表示当前使用的测速SDK版本无权限获取该参数。

### speed

测速过程，返回实时网速情况。

| 参数  | 说明         | 类型   | 可选值          | 默认值 |
| ----- | ------------ | ------ | --------------- | ------ |
| type  | 实时测速类型 | enum   | download/upload | 0      |
| speed | 实时网络速度 | Double | -               | 0      |

### finish

测速结束，返回平均网络速度。

| 参数     | 说明                     | 类型   | 可选值          | 默认值 |
| -------- | ------------------------ | ------ | --------------- | ------ |
| type     | 测速类型                 | String | download/upload | 0      |
| avgSpeed | 平均网络速度（单位Mbps） | Double | -               | 0      |
| flow     | 使用流量                 | Double | -               | 0      |
| crest    | 峰值                     | Double | -               | 0      |

**说明：**如果返回的值为`-1`，表示当前使用的测速SDK版本无权限获取该参数。

### busyData

测速结束，返回忙时过程相关数据。

| 参数        | 说明                | 类型   | 可选值          | 默认值 |
| ----------- | ------------------- | ------ | --------------- | ------ |
| type        | 测速类型            | String | download/upload | 0      |
| busyPing    | 下载\上传时延       | Int    | -               | 0      |
| busyPingMin | 下载\上传时延最小值 | Int    | -               | 0      |
| busyPingMax | 下载\上传时延最大值 | Int    | -               | 0      |
| busyJitter  | 下载\上传抖动       | Double | -               | -2.00  |

**说明：**如果返回的值为`-1`，表示当前使用的测速SDK版本无权限获取该参数。如果无法获取到忙时过程相关数据，则`busyPing、busyPingMax、busyPingMin` 返回`0`, `busyJitter` 类型数据返回`-2.00`

### loss

测速结束前，返回丢包率。

| 参数 | 说明            | 类型   | 可选值 | 默认值 |
| ---- | --------------- | ------ | ------ | ------ |
| loss | 丢包率（单位%） | Double | -      | 0      |

**说明：**如果`loss`的值返回为`-1`，表示当前使用的测速SDK版本不支持获取`loss`。

### error

错误信息接收，返回错误信息。


示例代码如下：

```swift
/// node 为可选值
speed.speedTest(node: node) {  ping, jitter, pingMin, pingMax in
    print("ping: \(ping), jitter: \(jitter), pingMin: \(pingMin), pingMax: \(pingMax)")
} speed: { type, speed in
    print("type: \(type), speed: \(speed)")
} finish: { type, avgSpeed, flow, speedCrest in
    print("avgSpeed: \(avgSpeed), flow：\(flow), speedCrest: \(speedCrest)")
} busyData: { type, downUpPing, downUpPingMin, downUpPingMax, downUpJitter in
    print("type: \(type), downUpPing: \(downUpPing), downUpPingMin: \(downUpPingMin), downUpPingMax: \(downUpPingMax), downUpJitter: \(downUpJitter)")
} loss: { loss in
    print("lossRate: \(loss)%")
} error: { err in
    print("error: ", error)
}
```

### \- 停止测速

```swift
speed.stopSpeedTest()
```

## iOS UI版

含有用户操作界面的版本

### \- 开始测速

跳转测速页面，返回测速数据。

```swift
if let nav = self.navigationController {
SpeedTestConfig.pushToSpeedViewController(navigationController: nav, unit: .KBps, isAutoSpeed: false) { result in
    /// 获取测速返回相关数据                                                                                                   
		print("result: \(result)")
	}
}
```

### \- 错误回调

错误回调编码规则:

| code  | 异常情况                           |
| ----- | ---------------------------------- |
| 10000 | 正在校验中                         |
| 10010 | 网络断开                           |
| 10030 | 请求失败                           |
| 20000 | 未初始化                           |
| 20010 | 获取节点失败                       |
| 20020 | 测速接口调用频率太高，3s内启动一次 |
| 20030 | 没有使用权限                       |
| 20040 | 节点连接失败                       |
| 40601 | 请确认你的appId或Key是否正确       |
| 40602 | 产品不存在                         |
| 40603 | 测速次数不足                       |
| 40604 | 到期无法使用                       |
| 40610 | 仅限（省）地区使用                 |
| 40611 | 仅限（省市）地区使用               |
| 40612 | 仅限（运营商）用户使用             |
| 40613 | 仅限XX.XX域名使用                  |
| 40614 | 仅限XX类型CPU使用                  |