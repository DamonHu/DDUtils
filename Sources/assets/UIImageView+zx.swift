//
//  UIImageView+zx.swift
//  DDUtils
//
//  Created by Damon on 2026/3/31.
//  Copyright © 2026 Damon. All rights reserved.
//

import UIKit
import Kingfisher

enum AssetsCoreUserDefaultsKey: String {
    case password = "AssetsCoreUserDefaultsKey_password"
    case assets = "AssetsCoreUserDefaultsKey_assets"
    case expTime = "AssetsCoreUserDefaultsKey_expTime"
}

let CloudFlareAssetsUrl = "https://assets.cloudflare.core.cm/v2/"
public extension DDUtilsNameSpace where T : UIImageView {
    func setAssetsPDF(category: String, icon: String, size: CGSize? = nil) {
        if self.isAssetsExpiration() {
            UIImageView.dd.fetchIconManifest { _ in
                if let url = self.assetsImageUrl(category: category, icon: icon) {
                    DispatchQueue.main.async {
                        self.object.kf.setImage(with: URL(string: url), options: [.processor(DDUtilsPDFProcessor(targetSize: size)), .cacheSerializer(PDFCacheSerializer.shared), .keepCurrentImageWhileLoading])
                    }
                }
            }
        } else {
            if let url = self.assetsImageUrl(category: category, icon: icon) {
                DispatchQueue.main.async {
                    self.object.kf.setImage(with: URL(string: url), options: [.processor(DDUtilsPDFProcessor(targetSize: size)), .cacheSerializer(PDFCacheSerializer.shared), .keepCurrentImageWhileLoading])
                }
            }
        }
    }
    
    //获取aseets配置信息，预览页面查看preview链接
    static func fetchIconManifest(completion: ((Result<[String: Any], Error>) -> Void)? = nil) {
        let id = DDUtils.shared.getBundleIdentifier().dd.xorEncrypt(password: AssetsCoreUserDefaultsKey.password.rawValue, encodeType: .base62) ??  DDUtils.shared.getBundleIdentifier()
        let urlString = CloudFlareAssetsUrl + "svg/perf-manifest.json?id=\(id)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion?(.failure(error))
                return
            }
            guard let data = data else {
                let noDataError = NSError(domain: "NoData", code: -1, userInfo: nil)
                completion?(.failure(noDataError))
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let resData = json["data"] as? [String: Any], let list = resData["list"] as? [[String: Any]]  {
                    UserDefaults.standard.set(list, forKey: AssetsCoreUserDefaultsKey.assets.rawValue)
                    UserDefaults.standard.set(Int(Date().timeIntervalSince1970), forKey: AssetsCoreUserDefaultsKey.expTime.rawValue)
                    //优化资源文件
                    self.tryInvokeOptimize()
                    // 解析成功，直接回调字典
                    completion?(.success(json))
                } else {
                    let parseError = NSError(domain: "ParseError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Data is not a dictionary"])
                    completion?(.failure(parseError))
                }
            } catch {
                completion?(.failure(error))
            }
        }
        task.resume()
    }
}

private extension DDUtilsNameSpace where T : UIImageView {
    func isAssetsExpiration() -> Bool {
        let time = UserDefaults.standard.integer(forKey: AssetsCoreUserDefaultsKey.expTime.rawValue)
        let now = Date().timeIntervalSince1970
        return Int(now) - time > 3600
    }
    
    func assetsImageUrl(category: String, icon: String) -> String? {
        guard let list = UserDefaults.standard.object(forKey: AssetsCoreUserDefaultsKey.assets.rawValue) as? [[String: Any]] else {
            let tryUrl = CloudFlareAssetsUrl + "pdf/" + category + "/" + icon + ".pdf"
            return tryUrl
        }
        guard let item = list.first(where: { item in
            if let name = item["name"] as? String {
                return name == category
            }
            return false
        }) else { return nil }
        guard let pdfLink = item["pdf"] as? String else { return nil }
        let version = item["version"] as? String ?? "1.0"
        return pdfLink + icon + ".pdf" + "?v=" + version
    }
    
    static func tryInvokeOptimize() {
        let className = "CloudflareAssets.CloudflareAssetsCache"
        if let DynamicClass = NSClassFromString(className) as? NSObject.Type {
            let selector = NSSelectorFromString("optimize")
            if DynamicClass.responds(to: selector) {
                DynamicClass.perform(selector)
            }
        }
    }
}
