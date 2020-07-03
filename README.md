# HDSwiftCommonTools

[HDCommonTools](https://github.com/DamonHu/HDCommonTools)的Swift版本，简单高效的集成常用功能，将常用的功能集合进来。目前还在完善中，也可以直接使用HDCommonTools的OC版本

## 一、导入项目

### 通过cocoapods导入

```
pod 'HDSwiftCommonTools'
```

### 通过文件导入

下载项目，将项目文件下的HDSwiftCommonTools文件夹里面的内容导入项目即可

## 二、使用

为了操作方便，基本上大部分`发起操作`都可以通过`单例`完成调用，针对系统已有数据类型的操作则提供了`hd`的点语法，举个例子

```
/** 可以通过单例进行调用 */

//打开系统设置
HDCommonTools.shared.openSystemSetting()
//获取软件构建版本
HDCommonTools.shared.getAppBuildVersionString()


/** 对已有数据类型的函数的功能扩充可以使用hd的链式调用 */

//字符串的md5加密
"哈哈是电话费".hd.encryptString(encryType: HDEncryType.md5)
//比较时间
Date().hd.compare(anotherDate: Date(timeIntervalSince1970: 1000), ignoreTime: true)
```


## 三、已实现功能，代码内更多功能

```
//角度渐变图片
let image = HDCommonTools.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
//线性渐变图片
let image2 = HDCommonTools.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .level)
//16进制颜色转为UIColor
let color = UIColorWithHexValue(hexValue: 0xffffff)
//16进制字符串转为UIColor
let color2 = UIColorWithHexString(hexString: "#ffffff")
//获取导航栏高度
let navigationBarHeight = HD_Default_NavigationBar_Height(vc: self)
        
        
//md5加密
"哈哈是电话费".hd.encryptString(encryType: HDEncryType.md5)
//sha加密
"sha1加密".hd.encryptString(encryType: HDEncryType.sha1)
"哈哈是电话费".hd.encryptString(encryType: HDEncryType.sha256)
//base64加密
"哈哈是电话费".hd.encryptString(encryType: HDEncryType.base64)
//base64解码
"5ZOI5ZOI5piv55S16K+d6LS5".hd.base64Decode()
//字符串转unicode
"哈哈是电话费".hd.unicodeEncode()
//unicode转中文
"\\u54c8\\u54c8\\u54c8".hd.unicodeDecode()
        
//软件版本
HDCommonTools.shared.getAppVersionString()
//软件构建版本
HDCommonTools.shared.getAppBuildVersionString()
//获取唯一标识
HDCommonTools.shared.getIDFAString()
```

## 四、其他

欢迎交流，互相学习

项目gitHub地址：[https://github.com/DamonHu/HDSwiftCommonTools](https://github.com/DamonHu/HDSwiftCommonTools)