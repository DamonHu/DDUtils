//
//  HDCommonTools+UI.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/2.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit



public extension HDCommonTools {
    //通过十六进制字符串获取颜色
    func getColorWithHexString(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex = ""
        if hexString.hasPrefix("#") {
            hex = String(hexString.suffix(hexString.count - 1))
        } else if (hexString.hasPrefix("0x") || hexString.hasPrefix("0X")) {
            hex = String(hexString.suffix(hexString.count - 2))
        }
        guard hex.count == 6 else {
            //不足6位不符合
            return UIColor.clear
        }
        
        var red: UInt32 = 0
        var green: UInt32 = 0
        var blue: UInt32 = 0
        
        var startIndex = hex.startIndex
        var endIndex = hex.index(hex.startIndex, offsetBy: 2)
        
        Scanner(string: String(hex[startIndex..<endIndex])).scanHexInt32(&red)
        
        startIndex = hex.index(hex.startIndex, offsetBy: 2)
        endIndex = hex.index(hex.startIndex, offsetBy: 4)
        Scanner(string: String(hex[startIndex..<endIndex])).scanHexInt32(&green)
        
        startIndex = hex.index(hex.startIndex, offsetBy: 4)
        endIndex = hex.index(hex.startIndex, offsetBy: 6)
        Scanner(string: String(hex[startIndex..<endIndex])).scanHexInt32(&blue)
        
        return UIColor(displayP3Red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    //获取当前的normalwindow
    func getCurrentNormalWindow() -> UIWindow? {
        var window = UIApplication.shared.keyWindow
        if window == nil || window?.windowLevel != UIWindow.Level.normal {
            for tmpWin in UIApplication.shared.windows {
                if tmpWin.windowLevel == UIWindow.Level.normal {
                    window = tmpWin
                    break
                }
            }
        }
        return window
    }
    
    //获取当前显示的vc
    func getCurrentVC() -> UIViewController? {
        let currentWindow = self.getCurrentNormalWindow()
        guard let window = currentWindow else { return nil }
        var vc: UIViewController?
        let frontView = window.subviews.first
        if let nextResponder = frontView?.next {
            if nextResponder is UIViewController {
                vc = nextResponder as? UIViewController
            } else {
                vc = window.rootViewController
            }
        } else {
            vc = window.rootViewController
        }
        
        if let currentVC = vc {
            if currentVC is UITabBarController {
                let tabBarController = currentVC as! UITabBarController
                vc = tabBarController.selectedViewController
            }
            if currentVC is UINavigationController {
                let navigationController = currentVC as! UINavigationController
                vc = navigationController.visibleViewController
            }
        }
        return vc
    }
    
   
    
    
}

//16进制颜色转为UIColor 0xffffff
public func UIColorWithHexValue(hexValue: Int, darkHexValue: Int = 0x333333, alpha: Float = 1.0, darkAlpha: Float = 1.0) -> UIColor {
    if #available(iOS 10.0, *) {
        if #available(iOS 13.0, *) {
            let dyColor = UIColor { (traitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .light {
                    return UIColor(displayP3Red: CGFloat(((Float)((hexValue & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((hexValue & 0xFF00) >> 8))/255.0), blue: CGFloat(((Float)((hexValue & 0xFF) >> 8))/255.0), alpha: CGFloat(alpha))
                } else {
                    return UIColor(displayP3Red: CGFloat(((Float)((darkHexValue & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((darkHexValue & 0xFF00) >> 8))/255.0), blue: CGFloat(((Float)(darkHexValue & 0xFF))/255.0), alpha: CGFloat(darkAlpha))
                }
            }
            return dyColor
        } else {
            return UIColor(displayP3Red: CGFloat(((Float)((hexValue & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((hexValue & 0xFF00) >> 8))/255.0), blue: CGFloat(((Float)(hexValue & 0xFF))/255.0), alpha: CGFloat(alpha))
        }
    } else {
        return UIColor(red: CGFloat(((Float)((hexValue & 0xFF0000) >> 16))/255.0), green: CGFloat(((Float)((hexValue & 0xFF00) >> 8))/255.0), blue: CGFloat(((Float)(hexValue & 0xFF))/255.0), alpha: CGFloat(alpha))
    };
}

//16进制字符串转为UIColor #ffffff
public func UIColorWithHexString(hexString: String, darkHexValue: String = "0x333333", alpha: CGFloat = 1.0, darkAlpha: CGFloat = 1.0) -> UIColor {
    if #available(iOS 13.0, *) {
        let dyColor = UIColor { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .light {
                return HDCommonTools.shared.getColorWithHexString(hexString: hexString, alpha: alpha)
            } else {
                return HDCommonTools.shared.getColorWithHexString(hexString: darkHexValue, alpha: darkAlpha)
            }
        }
        return dyColor
    } else {
        return HDCommonTools.shared.getColorWithHexString(hexString: hexString, alpha: alpha)
    }
}

///高度坐标配置
public let UIScreenWidth = UIScreen.main.bounds.size.width
public let UIScreenHeight = UIScreen.main.bounds.size.height

//状态栏高度
public let HD_StatusBar_Height = UIApplication.shared.statusBarFrame.size.height

//导航栏高度
public func HD_Default_NavigationBar_Height(vc: UIViewController? = nil) -> CGFloat {
    if let navigationController = vc?.navigationController {
        return navigationController.navigationBar.frame.size.height
    } else {
        return UINavigationController(nibName: nil, bundle: nil).navigationBar.frame.size.height
    }
}

//tabbar高度
public func HD_Default_Tabbar_Height(vc: UIViewController? = nil) -> CGFloat {
    if let tabbarViewController = vc?.tabBarController {
        return tabbarViewController.tabBar.frame.size.height
    } else {
        return UITabBarController(nibName: nil, bundle: nil).tabBar.frame.size.height
    }
}

//状态栏和导航栏总高度
public func HD_Default_Nav_And_Status_Height(vc: UIViewController? = nil) -> CGFloat {
    return HD_Default_NavigationBar_Height(vc: vc) + HD_StatusBar_Height
}
