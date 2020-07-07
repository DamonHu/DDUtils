//
//  ViewController.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/2.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //角度渐变图片
        _ = HDCommonTools.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
//        //线性渐变图片
        _ = HDCommonTools.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .leftToRight)
        //16进制颜色转为UIColor
        _ =  UIColor(with: 0xffffff)
        //16进制字符串转为UIColor
        
        _ = UIColor(with: "#ffffff")
        //获取导航栏高度
        _ = HD_Default_NavigationBar_Height(vc: self)
        
        
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
        
        let string = "截取字符串"
        print(string.hd.subString(rang: NSRange(location: 2, length: 5)))
        
        print(HDCommonTools.shared.getFileDirectory(type: .home).absoluteString)
        
        HDCommonTools.shared.startVibrate(repeated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            HDCommonTools.shared.stopVibrate()
        }
        
        self.createUI()
    }
    
    func createUI() {
        let button = UIButton(type: .custom)
        let image = HDCommonTools.shared.getLinearGradientImage(colors:  [UIColor.red, UIColor.black, UIColor.blue], directionType: .leftToRight)
        button.setImage(image, for: .normal)
        self.view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        button.addTarget(self, action: #selector(click), for: UIControl.Event.touchUpInside)
        
        let button2 = UIButton(type: .custom)
        let image2 = HDCommonTools.shared.getRadialGradientImage(colors: [UIColor.red, UIColor.black, UIColor.blue], raduis: 45)
        button2.setImage(image2, for: .normal)
        self.view.addSubview(button2)
        button2.frame = CGRect(x: 100, y: 300, width: 100, height: 100)
        
        button2.addTarget(self, action: #selector(playMusic), for: UIControl.Event.touchUpInside)
    }
    
    @objc func click() {
        let url = Bundle.main.url(forResource: "click", withExtension: "caf")
        HDCommonTools.shared.playEffect(url: url, vibrate: true)
    }
    

    @objc func playMusic() {
        let url = Bundle.main.url(forResource: "空谷", withExtension: "wav")
        HDCommonTools.shared.playMusic(url: url, repeated: false)
    }
}

