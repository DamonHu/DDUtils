//
//  ViewController.swift
//  DDUtils
//
//  Created by Damon on 2020/7/2.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit
import CryptoKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let but = UIButton()
        print(UIButton.dd.className())
        print(but.dd.className())

        let testModel = TestModel()
        let obj = DDUtils.shared.getDictionary(object: testModel)
        if let name = obj["name"] as? String {
            print(name)
        }
        
        if #available(iOS 13.0, *) {
            let key = SymmetricKey.init(data: Data.dd.data(from: "d5a423f64b607ea7c65b311d855dc48f36114b227bd0c7a3d403f6158a9e4412", encodeType: .hex)!)
            let test = "17777777777".dd.aesGCMEncrypt(key: key)
            print(test, test?.dd.aesGCMDecrypt(key: key))

            print("hmac", "DDUtils".dd.hmac(hashType: .sha1, password: "67FG", encodeType: .hex))
        }

        print(DDUtils_HomeIndicator_Height, DDUtils_Default_Tabbar_Height())

        let cbc = "mmmsss".dd.aesCBCEncrypt(password: "12345678901234561234567890123456")!
        print("cbc", cbc, cbc.dd.aesCBCDecrypt(password: "12345678901234561234567890123456"))

        let data = Data.dd.data(from: "d5a423f64b607ea7c65b311d855dc48f36114b227bd0c7a3d403f6158a9e4412", encodeType: .hex)
        print("hash1", data?.dd.encodeString(encodeType: .hex))

        for item in TestEnum.allCases {
            print(item)
        }

        //        DDUtils.shared.openAppStoreReviewPage(openType: .app)
        
        let filePath = Bundle.main.path(forResource: "1594468497552.mp4", ofType: "")
        if let path = filePath {
            let duration = DDUtils.shared.getVideoDuration(videoURL: URL(fileURLWithPath: path))
            print("时间: ", duration)
            
            let size = DDUtils.shared.getVideoSize(videoURL: URL(fileURLWithPath: path))
            print("size: ", size)
            
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                print(data.dd.encryptString(encryType: .sha1))
            }
            
        }
        
        /** 可以通过单例进行调用 */
        
        //角度渐变图片
        _ = DDUtils.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
        //线性渐变图片
        _ = DDUtils.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .minXToMaxX)
        //16进制颜色转为UIColor
        _ =  UIColor.dd.color(hexValue: 0xffffff)
        //16进制字符串转为UIColor
        _ = UIColor.dd.color(hexString: "#FFFFFF")
        //获取导航栏高度
        _ = DDUtils_Default_NavigationBar_Height(vc: self)
        
        /** 对部分数据类型的函数的功能扩充可以使用dd的链式调用 */
        
        //16进制颜色转为UIColor
        _ = UIColor.dd.color(hexValue: 0xffffff)
        //md5加密
        _ = "哈哈是电话费".dd.hashString(hashType: .md5)
        //sha加密
        _ = "sha1加密".dd.hashString(hashType: .sha1)
        _ = "哈哈是电话费".dd.hashString(hashType: .sha256)
        //base64加密
//        _ = "哈哈是电话费".dd encryptString(encryType: .base64)
        //base64解码
        let base64 = "5ZOI5ZOI5piv55S16K+d6LS5".dd.encodeString(from: .base64, to: .system(.utf8))
        print("base64", base64)
        //字符串转unicode
        let toUnicode = "哈哈是电话费\n".dd.unicodeEncode()
        print("toUnicode", toUnicode)
        //unicode转中文
        let unicode = "\\u6e56\\u5357\\u6000\\u5316\\ua\\u8bd5\\u8bd5\\ua\\ua\\u58eb\\u5927\\u592b\\u6492".dd.unicodeDecode()
        print("unicode", unicode)
        //软件版本
        _ = DDUtils.shared.getAppVersionString()
        //软件构建版本
        _ = DDUtils.shared.getAppBuildVersionString()
        //获取唯一标识
        _ = DDUtils.shared.getIDFAString()
        
        //比较时间
        _ = Date().dd.compare(anotherDate: Date(timeIntervalSince1970: 1000), ignoreTime: true)
        
        //更安全快捷的截取字符串
        let string = "截取字符串"
        print(string.dd.subString(rang: NSRange(location: 2, length: 5)))
        
        //获取文件路径
        print(DDUtils.shared.getFileDirectory(type: .home).absoluteString)
        
        //手机震动
        DDUtils.shared.startVibrate(repeated: true)
        
        //五秒之后结束震动
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            DDUtils.shared.stopVibrate()
        }
        
        //播放音乐
        DDUtils.shared.playMusic(url: URL(string: "https://file-fat.shinningmorning.com/voice/voice_xiongdi.m4a"), repeated: true)
        DispatchQueue.init(label: "other quene").async {
            ///type设置为async，输出为lll, mmm, ssss, 设置为sync，输出为lll，ssss，mmm
            DDUtils.shared.runInMainThread(type: .sync) {
                print("ssssssss")
            }
            print("mmmm")
        }
        print("lllllll")


        self.createUI()
    }
    
    func createUI() {
        let button = UIButton(type: .custom)
        let image = DDUtils.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .minXToMaxX)
        button.setImage(image, for: .normal)
        self.view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        button.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        
        let button2 = UIButton(type: .custom)
        let image2 = DDUtils.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
        button2.setImage(image2, for: .normal)
        self.view.addSubview(button2)
        button2.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        
        button2.addTarget(self, action: #selector(playMusic), for: UIControl.Event.touchUpInside)
    }
    
    @objc func click() {
        let url = Bundle.main.url(forResource: "click", withExtension: "caf")
        DDUtils.shared.playEffect(url: url, vibrate: true)
    }
    

    @objc func playMusic() {
        let url = Bundle.main.url(forResource: "空谷", withExtension: "wav")
        DDUtils.shared.playMusic(url: url, repeated: false)
        
        
    }
}

