//
//  HDCommonTools+system.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/3.
//  Copyright © 2020 Damon. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

public extension HDCommonTools {
    //获取软件版本
    func getAppVersionString() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        return version ?? ""
    }
    
    //获取软件构建版本
    func getAppBuildVersionString() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        return version ?? ""
    }
    
    //获取系统的iOS版本
    func getIOSVersionString() -> String {
        return UIDevice.current.systemVersion
    }
    
    //获取系统语言
    func getIOSLanguageStr() -> String {
        let language = Bundle.main.preferredLocalizations.first
        return language ?? ""
    }
    
    //获取软件Bundle Identifier
    func getBundleIdentifier() -> String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    //获取本机机型标识
    func getSystemHardware() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    //获取本机上次重启时间
    func getSystemUpTime() -> TimeInterval {
        let timeInterval = ProcessInfo.processInfo.systemUptime
        return Date().timeIntervalSince1970 - timeInterval
    }
    
    /// 模拟软件唯一标示
    /// - Parameter idfvIfFailed: 如果用户禁止获取本机idfa，是否去尝试使用idfv
    /// - Returns: 唯一标识
    func getIDFAString(idfvIfFailed: Bool = true) -> String {
        if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        } else {
            return UIDevice.current.identifierForVendor?.uuidString ?? ""
        }
    }
}
