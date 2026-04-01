//
//  Data+dd.swift
//  DDUtils
//
//  Created by Damon on 2021/5/31.
//  Copyright © 2021 Damon. All rights reserved.
//

import Foundation
import CommonCrypto
#if canImport(CryptoKit)
import CryptoKit
#endif

public enum DDUtilsHashType {
    case md5
    case sha1
    case sha224
    case sha256
    case sha384
    case sha512
}

public enum DDUtilsEncodeType {
    case hex
    case base64
    case base62
    case system(String.Encoding)
}

let DDKitUtilsAlphabet = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

public extension DDUtilsNameSpace where T == Data {
    //string生成Data，兼容hex和base64
    static func data(from string: String, encodeType: DDUtilsEncodeType) -> Data? {
        switch encodeType {
        case .hex:
            let len = string.count / 2
            var data = Data(capacity: len)
            var i = string.startIndex
            for _ in 0..<len {
                let j = string.index(i, offsetBy: 2)
                let bytes = string[i..<j]
                if var num = UInt8(bytes, radix: 16) {
                    data.append(&num, count: 1)
                } else {
                    return nil
                }
                i = j
            }
            return data
            
        case .base64:
            return Data(base64Encoded: string)
            
        case .system(let encode):
            return string.data(using: encode)
            
        case .base62:
            guard !string.isEmpty else { return nil }
            
            let alphabet = DDKitUtilsAlphabet
            let charToIndex = Dictionary(uniqueKeysWithValues: alphabet.enumerated().map { ($1, $0) })
            // ✅ 只统计“前导0”
            let zeroChar = alphabet[0]
            var leadingZeroCount = 0
            for char in string {
                if char == zeroChar {
                    leadingZeroCount += 1
                } else {
                    break
                }
            }
            // 转数字
            var digits = [Int]()
            digits.reserveCapacity(string.count)
            for char in string {
                guard let index = charToIndex[char] else { return nil }
                digits.append(index)
            }
            
            var bytes = [UInt8]()
            var currentDigits = digits
            
            while !currentDigits.isEmpty {
                var remainder = 0
                var nextDigits = [Int]()
                nextDigits.reserveCapacity(currentDigits.count)
                
                for digit in currentDigits {
                    let current = digit + remainder * 62
                    let quotient = current >> 8
                    remainder = current & 0xff
                    
                    if !nextDigits.isEmpty || quotient > 0 {
                        nextDigits.append(quotient)
                    }
                }
                
                bytes.append(UInt8(remainder))
                currentDigits = nextDigits
            }
            
            // ✅ 只补前导0（关键修复）
            bytes.append(contentsOf: Array(repeating: 0, count: leadingZeroCount))
            
            return Data(bytes.reversed())
        }
    }
    
    //编码
    func encodeString(encodeType: DDUtilsEncodeType) -> String? {
        switch encodeType {
        case .hex:
            return object.map { String(format: "%02hhx", $0) }.joined()
            
        case .base64:
            return object.base64EncodedString()
            
        case .system(let encode):
            return String(data: object, encoding: encode)
            
        case .base62:
            guard !self.object.isEmpty else { return "" }
            let alphabet = DDKitUtilsAlphabet
            // ✅ 只统计“前导0”
            var leadingZeroCount = 0
            for byte in self.object {
                if byte == 0 {
                    leadingZeroCount += 1
                } else {
                    break
                }
            }
            var bytes = Array(self.object)
            var result = [Character]()
            result.reserveCapacity(bytes.count)
            
            while !bytes.isEmpty {
                var remainder = 0
                var nextBytes = [UInt8]()
                nextBytes.reserveCapacity(bytes.count)
                
                for byte in bytes {
                    let current = Int(byte) + (remainder << 8)
                    let quotient = current / 62
                    remainder = current % 62
                    
                    if !nextBytes.isEmpty || quotient > 0 {
                        nextBytes.append(UInt8(quotient))
                    }
                }
                
                result.append(alphabet[remainder])
                bytes = nextBytes
            }
            // ✅ 只处理前导0（关键修复）
            result.append(contentsOf: Array(repeating: alphabet[0], count: leadingZeroCount))
            
            return String(result.reversed())
        }
    }
    
    ///hash计算
    func hashString(hashType: DDUtilsHashType, lowercase: Bool = true) -> String {
        var output = NSMutableString()
        switch hashType {
        case .md5:
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_MD5(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha1:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA1(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha224:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA224_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA224(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_SHA224_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha256:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA256(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_SHA256_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha384:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA384_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA384(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_SHA384_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        case .sha512:
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
            _ = object.withUnsafeBytes { (messageBytes) -> Bool in
                CC_SHA512(messageBytes.baseAddress, CC_LONG(object.count), &digest)
                return true
            }
            
            output = NSMutableString(capacity: Int(CC_SHA512_DIGEST_LENGTH))
            for byte in digest{
                output.appendFormat("%02x", byte)
            }
        }
        
        if !lowercase {
            return String(output).uppercased()
        }
        return String(output)
    }
    
    /*
     AES CBC加密
     model: CBC
     padding: PKCS7Padding
     AES block Size: 128
     **/
    func aesCBCEncrypt(password: String, ivString: String = "abcdefghijklmnop", encodeType: DDUtilsEncodeType = .base64) -> String? {
        guard let iv = ivString.data(using: .utf8), let key = password.data(using: .utf8) else { return nil }
        assert(iv.count == kCCKeySizeAES128, "iv should be \(kCCKeySizeAES128) bytes")
        assert(key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES192 || key.count == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        let encryptData = self._crypt(data: object, key: key, iv: iv, option: CCOperation(kCCEncrypt))
        return encryptData?.dd.encodeString(encodeType: encodeType)
    }
    
    ///AES CBC解密
    func aesCBCDecrypt(password: String, ivString: String = "abcdefghijklmnop") -> String? {
        guard let iv = ivString.data(using: .utf8), let key = password.data(using: .utf8) else { return nil }
        assert(iv.count == kCCKeySizeAES128, "iv should be \(kCCKeySizeAES128) bytes")
        assert(key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES192 || key.count == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        guard let encryptData = self._crypt(data: object, key: key, iv: iv, option: CCOperation(kCCDecrypt)) else {
            return nil
        }
        return String(data: encryptData, encoding: String.Encoding.utf8)
    }
    
    //XOR加密
    func xorEncrypt(password: String, encodeType: DDUtilsEncodeType = .base64) -> String? {
        let key = Array(password.utf8)
        let inputBytes = Array(self.object)
        var outputBytes = [UInt8]()
        for i in 0..<inputBytes.count {
            // 将输入字节与 Key 的对应字节进行异或
            outputBytes.append(inputBytes[i] ^ key[i % key.count])
        }
        // 返回 Base64 字符串以便在 URL 中传输
        return Data(outputBytes).dd.encodeString(encodeType: encodeType)
    }
    
    //XOR解密
    func xorDecrypt(password: String) -> String? {
        let key = Array(password.utf8)
        let inputBytes = Array(self.object)
        var outputBytes = [UInt8]()
        for i in 0..<inputBytes.count {
            outputBytes.append(inputBytes[i] ^ key[i % key.count])
        }
        return String(bytes: outputBytes, encoding: .utf8)
    }
}

#if canImport(CryptoKit)
@available(iOS 13.0, *)
public extension DDUtilsNameSpace where T == Data {
    //AES GCM加密
    func aesGCMEncrypt(password: String, encodeType: DDUtilsEncodeType = .base64, nonce: AES.GCM.Nonce? = AES.GCM.Nonce()) -> String? {
        guard let key = password.data(using: .utf8) else { return nil }
        assert(key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES192 || key.count == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        return self.aesGCMEncrypt(key: SymmetricKey.init(data: key), encodeType: encodeType, nonce: nonce)
    }
    
    ///AES GCM加密
    func aesGCMEncrypt(key: SymmetricKey, encodeType: DDUtilsEncodeType = .base64, nonce: AES.GCM.Nonce? = AES.GCM.Nonce()) -> String? {
        assert(key.bitCount / 8 == kCCKeySizeAES128 || key.bitCount / 8 == kCCKeySizeAES192 || key.bitCount / 8 == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        guard let sealedBox = try? AES.GCM.seal(object, using: key, nonce:  nonce) else { return nil }
        guard let encode = sealedBox.combined else { return nil }
        return encode.dd.encodeString(encodeType: encodeType)
    }
    //AES GCM解密
    func aesGCMDecrypt(password: String) -> String? {
        guard let key = password.data(using: .utf8) else { return nil }
        assert(key.count == kCCKeySizeAES128 || key.count == kCCKeySizeAES192 || key.count == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        let keyData = SymmetricKey.init(data: key)
        return self.aesGCMDecrypt(key: keyData)
    }
    
    //AES GCM解密
    func aesGCMDecrypt(key: SymmetricKey) -> String? {
        assert(key.bitCount / 8 == kCCKeySizeAES128 || key.bitCount / 8 == kCCKeySizeAES192 || key.bitCount / 8 == kCCKeySizeAES256, "Invalid key length. Available length is \(kCCKeySizeAES128) \(kCCKeySizeAES192) \(kCCKeySizeAES256)")
        guard let sealedBox = try? AES.GCM.SealedBox.init(combined: object) else { return nil }
        guard let decry = try? AES.GCM.open(sealedBox, using: key) else { return nil }
        return String(decoding: decry, as: UTF8.self)
    }
    
    ///HMAC计算
    func hmac(hashType: DDUtilsHashType, password: String, encodeType: DDUtilsEncodeType = .base64) -> String? {
        let key = SymmetricKey.init(data: password.data(using:String.Encoding.utf8)!)
        return self.hmac(hashType: hashType, key: key, encodeType: encodeType)
    }
    
    ///HMAC计算
    func hmac(hashType: DDUtilsHashType, key: SymmetricKey, encodeType: DDUtilsEncodeType = .base64) -> String? {
        switch hashType {
        case .md5:
            let sign = HMAC<Insecure.MD5>.authenticationCode(for: object, using: key)
            return Data(sign).dd.encodeString(encodeType: encodeType)
        case .sha1:
            let sign = HMAC<Insecure.SHA1>.authenticationCode(for: object, using: key)
            return Data(sign).dd.encodeString(encodeType: encodeType)
        case .sha224:
            assert(false, "unsupported hash type")
            return nil
        case .sha256:
            let sign = HMAC<SHA256>.authenticationCode(for: object, using: key)
            return Data(sign).dd.encodeString(encodeType: encodeType)
        case .sha384:
            let sign = HMAC<SHA384>.authenticationCode(for: object, using: key)
            return Data(sign).dd.encodeString(encodeType: encodeType)
        case .sha512:
            let sign = HMAC<SHA512>.authenticationCode(for: object, using: key)
            return Data(sign).dd.encodeString(encodeType: encodeType)
        }
    }
}
#endif

private extension DDUtilsNameSpace where T == Data {
    func _crypt(data: Data, key: Data, iv: Data, option: CCOperation) -> Data? {
        let cryptLength = data.count + kCCBlockSizeAES128
        var cryptData   = Data(count: cryptLength)
        
        let keyLength = key.count
        let options   = CCOptions(kCCOptionPKCS7Padding)
        
        var bytesLength = Int(0)
        
        let status = cryptData.withUnsafeMutableBytes { cryptBytes in
            data.withUnsafeBytes { dataBytes in
                iv.withUnsafeBytes { ivBytes in
                    key.withUnsafeBytes { keyBytes in
                        CCCrypt(option, CCAlgorithm(kCCAlgorithmAES), options, keyBytes.baseAddress, keyLength, ivBytes.baseAddress, dataBytes.baseAddress, data.count, cryptBytes.baseAddress, cryptLength, &bytesLength)
                    }
                }
            }
        }
        
        guard UInt32(status) == UInt32(kCCSuccess) else {
            return nil
        }
        
        cryptData.removeSubrange(bytesLength..<cryptData.count)
        return cryptData
    }
}


