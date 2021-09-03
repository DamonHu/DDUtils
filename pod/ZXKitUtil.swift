//
//  ZXKitUtil.swift
//  ZXKitUtil
//
//  Created by Damon on 2020/7/2.
//  Copyright © 2020 Damon. All rights reserved.
//

import Foundation

open class ZXKitUtil: NSObject {
    private static let instance = ZXKitUtil()
    open class var shared: ZXKitUtil {
        return instance
    }
}

public extension ZXKitUtil {
    /// 获取class\struct的所有属性
    /// - Parameters:
    ///   - object: 需要获取的属性
    ///   - debug: 是否输入调试信息
    /// - Returns: 属性
    func getDictionary(object: Any, debug: Bool = false) -> [String: Any] {
        let reflection = Mirror(reflecting: object).children
        var dictionary = [String : Any]()

        if debug {
            print("--- ZXKitUtil.getDictionary(object:debug:) ---")
        }
        for (key, value) in reflection {
            if let key = key {
                if debug {
                    print("--- \(key) --- \(type(of: value)) --- \(value)")
                }
                dictionary[key] = value
            }
        }
        return dictionary
    }
}
