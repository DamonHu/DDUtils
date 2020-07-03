//
//  UIImage+hd.swift
//  HDSwiftCommonTools
//
//  Created by Damon on 2020/7/3.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit
import Foundation

public enum HDGradientDirection {
    case level              //AC - BD
    case vertical           //AB - CD
    case upwardDiagonalLine //A - D
    case downDiagonalLine   //C - B
}
//      A         B
//       _________
//      |         |
//      |         |
//       ---------
//      C         D

public extension UIImage {
    var hd :HDNameSpace<UIImage> {
        return HDNameSpace(object: self)
    }
    static var hd = UIImage.self
}

public extension HDNameSpace where T == UIImage {
    func sssss() -> Void {
        
    }
    //通过颜色获取纯色图片
    static func getImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        var image: UIImage?
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        if let context = context {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return image ?? UIImage()
    }
    
    //线性渐变
    static func getLinearGradientImage(colors: [UIColor], directionType: HDGradientDirection, size: CGSize = CGSize(width: 100, height: 100)) -> UIImage {
        if (colors.count == 0) {
            return UIImage()
        } else if (colors.count == 1) {
            return self.getImageWithColor(color: colors.first!)
        }
        let gradientLayer = CAGradientLayer()
        var cgColors = [CGColor]()
        var locations = [NSNumber]()
        for i in 0..<colors.count {
            let color = colors[i]
            cgColors.append(color.cgColor)
            let location = Float(i)/Float(colors.count - 1)
            locations.append(NSNumber(value: location))
        }
        
        gradientLayer.colors = cgColors
        gradientLayer.locations = locations
        
        if (directionType == .level) {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        } else if (directionType == .vertical){
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        } else if (directionType == .upwardDiagonalLine){
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        } else if (directionType == .downDiagonalLine){
            gradientLayer.startPoint = CGPoint(x: 0, y: 1)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }
        
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, false, 0)
        var gradientImage: UIImage?
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        if let context = context {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        return gradientImage ?? UIImage()
    }
    
    //角度渐变
    static func getRadialGradientImage(colors: [UIColor], raduis: CGFloat, size: CGSize = CGSize(width: 100, height: 100)) -> UIImage {
        if (colors.count == 0) {
            return UIImage()
        } else if (colors.count == 1) {
            return self.getImageWithColor(color: colors.first!)
        }
        
        UIGraphicsBeginImageContext(size);
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: size.width/2.0, y: size.height / 2.0), radius: raduis, startAngle: 0, endAngle: CGFloat(Double.pi) * 2, clockwise: false)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var cgColors = [CGColor]()
        var locations = [CGFloat]()
        for i in 0..<colors.count {
            let color = colors[i]
            cgColors.append(color.cgColor)
            let location = Float(i)/Float(colors.count - 1)
            locations.append(CGFloat(location))
        }
        
        let colorGradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations)
        guard let gradient = colorGradient else { return UIImage() }
        
        let pathRect = path.boundingBox;
        let center = CGPoint(x: pathRect.midX, y: pathRect.midY)
        
        let currentContext: CGContext? = UIGraphicsGetCurrentContext()
        guard let context = currentContext else {
            return UIImage()
        }
        context.saveGState();
        context.addPath(path);
        context.clip()
        context.drawRadialGradient(gradient, startCenter: center, startRadius: 0, endCenter: center, endRadius: raduis, options: .drawsBeforeStartLocation);
        context.restoreGState();
        
        //        CGGradientRelease(gradient);
        //        CGColorSpaceRelease(colorSpace);
        //
        //        CGPathRelease(path);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img ?? UIImage()
    }
}
