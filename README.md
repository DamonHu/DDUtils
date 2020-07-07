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
        
        //角度渐变图片
        _ = HDCommonTools.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
        //线性渐变图片
        _ = HDCommonTools.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .leftToRight)
        //16进制颜色转为UIColor
        _ =  UIColor(with: 0xffffff)
        //16进制字符串转为UIColor
        
        _ = UIColor(with: "#ffffff")
        //获取导航栏高度
        _ = HD_Default_NavigationBar_Height(vc: self)
        
        /** 对部分数据类型的函数的功能扩充可以使用hd的链式调用 */
        
        //md5加密
        _ = "哈哈是电话费".hd.encryptString(encryType: HDEncryType.md5)
        //sha加密
        _ = "sha1加密".hd.encryptString(encryType: HDEncryType.sha1)
        _ = "哈哈是电话费".hd.encryptString(encryType: HDEncryType.sha256)
        //base64加密
        _ = "哈哈是电话费".hd.encryptString(encryType: HDEncryType.base64)
        //base64解码
        _ = "5ZOI5ZOI5piv55S16K+d6LS5".hd.base64Decode()
        //字符串转unicode
        _ = "哈哈是电话费".hd.unicodeEncode()
        //unicode转中文
        _ = "\\u54c8\\u54c8\\u54c8".hd.unicodeDecode()
        
        //软件版本
        _ = HDCommonTools.shared.getAppVersionString()
        //软件构建版本
        _ = HDCommonTools.shared.getAppBuildVersionString()
        //获取唯一标识
        _ = HDCommonTools.shared.getIDFAString()
        
        //比较时间
        _ = Date().hd.compare(anotherDate: Date(timeIntervalSince1970: 1000), ignoreTime: true)
        
        //更安全快捷的截取字符串
        let string = "截取字符串"
        print(string.hd.subString(rang: NSRange(location: 2, length: 5)))
        
        //获取文件路径
        print(HDCommonTools.shared.getFileDirectory(type: .home).absoluteString)
        
        //手机震动
        HDCommonTools.shared.startVibrate(repeated: true)
        
        //五秒之后结束震动
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            HDCommonTools.shared.stopVibrate()
        }
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