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

使用单例即可快速调用各类功能

```
//MD5加密
HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.md5)
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
        HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.md5)
        //sha加密
        HDCommonTools.shared.encryptString("sha1加密", encryType: HDEncryType.sha1)
        HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.sha256)
        //base64加密
        HDCommonTools.shared.encryptString("哈哈是电话费", encryType: HDEncryType.base64)
        //base64解码
        HDCommonTools.shared.base64Decode(base64String: "5ZOI5ZOI5piv55S16K+d6LS5")
        //字符串转unicode
        HDCommonTools.shared.unicodeEncode(string: "哈哈哈")
        //unicode转中文
        HDCommonTools.shared.unicodeDecode(unicodeString: "\\u54c8\\u54c8\\u54c8")
        
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