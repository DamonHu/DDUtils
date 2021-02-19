//
//  HDCommonToolsSwift+idfa.swift
//  HDCommonToolsSwift
//
//  Created by Damon on 2021/2/19.
//  Copyright © 2021 Damon. All rights reserved.
//

import Foundation
#if canImport(AppTrackingTransparency)
import AppTrackingTransparency
#endif
#if canImport(AdSupport)
import AdSupport
#else
//
#endif

public extension HDCommonToolsSwift {
    func requestIDFAPermission(complete: @escaping ((HDPermissionStatus) -> Void)) -> Void {
        if #available(iOS 14.0, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                    case .notDetermined:
                        complete(.notDetermined)
                    case .restricted:
                        complete(.restricted)
                    case .denied:
                        complete(.denied)
                    case .authorized:
                        complete(.authorized)
                    default:
                        complete(.authorized)
                }
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                complete(.authorized)
            } else {
                complete(.denied)
            }
        }
    }

    ///检测权限
    func checkIDFAPermission(type: HDPermissionType, complete: @escaping ((HDPermissionStatus) -> Void)) -> Void {
        if #available(iOS 14.0, *) {
            let status = ATTrackingManager.trackingAuthorizationStatus
            switch status {
                case .notDetermined:
                    complete(.notDetermined)
                case .restricted:
                    complete(.restricted)
                case .denied:
                    complete(.denied)
                case .authorized:
                    complete(.authorized)
                default:
                    complete(.authorized)
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                complete(.authorized)
            } else {
                complete(.denied)
            }
        }
    }
}
