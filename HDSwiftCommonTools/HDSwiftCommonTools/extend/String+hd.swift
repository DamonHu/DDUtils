//
//  String+hd.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/3.
//  Copyright © 2020 Damon. All rights reserved.
//

import Foundation
import CommonCrypto

public enum HDEncryType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
    case base64
}

public extension String {
    var hd :HDNameSpace<String> {
        return HDNameSpace(object: self)
    }
}

public extension HDNameSpace where T == String {
    //截取字符串
    func subString(rang: NSRange) -> String {
        var string = String()
        var subRange = rang
        if rang.location < 0 {
            subRange = NSRange(location: 0, length: rang.length)
        }
        if object.count < subRange.location + subRange.length {
            //直接返回完整的
            subRange = NSRange(location: subRange.location, length: object.count - subRange.location)
        }
        let startIndex = object.index(object.startIndex,offsetBy: subRange.location)
        let endIndex = object.index(object.startIndex,offsetBy: (subRange.location + subRange.length))
        let subString = object[startIndex..<endIndex]
        string = String(subString)
        return string
    }
    
    //unicode转中文
    func unicodeDecode() -> String {
        let tempStr1 = object.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
    //字符串转unicode
    func unicodeEncode() -> String {
        let dataEncode = object.data(using: String.Encoding.nonLossyASCII)
        let unicodeStr = String(data: dataEncode!, encoding: String.Encoding.utf8)
        return unicodeStr!
    }
    
    //base64解码
    func base64Decode(lowercase: Bool = true) -> String {
        let decodeData:Data? = Data(base64Encoded: object)
        guard let utf8Data = decodeData else{
            return ""
        }
        var string = String(data: utf8Data, encoding: String.Encoding.utf8) ?? ""
        if !lowercase {
            string = string.uppercased()
        }
        return string
    }
    
    //MARK: 加密
    func encryptString(encryType: HDEncryType, lowercase: Bool = true) -> String {
        let data: Data = object.data(using: String.Encoding.utf8) ?? Data()
        var output = NSMutableString()
        
        switch encryType {
        case .md5:
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_MD5(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha1:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA1(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha224:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA224_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA224(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_SHA224_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha256:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA256(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_SHA256_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha384:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA384_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA384(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_SHA384_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha512:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            _ = data.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA512(messageBytes.baseAddress, CC_LONG(data.count), &digest)
                return true
            }

            output = NSMutableString(capacity: Int(CC_SHA512_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .base64:
            let base64Encoded:String = data.base64EncodedString()
            output = NSMutableString (string: base64Encoded)
        }
        
        if !lowercase {
            return String(output).uppercased()
        }
        return String(output)
    }
}
