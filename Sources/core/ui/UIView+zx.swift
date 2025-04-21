//
//  UIView+dd.swift
//  DDUtils
//
//  Created by Damon on 2020/7/5.
//  Copyright © 2020 Damon. All rights reserved.
//

import UIKit

extension UIView: DDUtilsNameSpaceWrappable {

}

public extension DDUtilsNameSpace where T : UIView {
    ///添加阴影
    func addLayerShadow(color: UIColor, offset: CGSize, radius: CGFloat, cornerRadius: CGFloat? = nil) -> Void {
        object.layer.shadowColor = color.cgColor
        object.layer.shadowOffset = offset
        object.layer.shadowRadius = radius
        object.layer.shadowOpacity = 1
        object.layer.shouldRasterize = true
        object.layer.rasterizationScale = UIScreen.main.scale
        if let cornerRadius = cornerRadius {
            object.layer.cornerRadius = cornerRadius
        }
    }
    
    ///添加内阴影
    func addInnerShadow(color: UIColor = .black, offset: CGSize = .zero, opacity: Float = 0.8, radius: CGFloat = 3) {
        // 更新自动布局的 bounds
        object.setNeedsLayout()
        object.layoutIfNeeded()
        self.removeInnerShadow()
        // 创建一个阴影图层
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = "InnerShadowLayer"
        shadowLayer.frame = object.bounds
        
        // 设置阴影颜色、偏移、透明度和模糊半径
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        
        // 设置填充规则为 even-odd
        shadowLayer.fillRule = .evenOdd
        
        // 创建路径
        let outerPath = UIBezierPath(rect: object.bounds.insetBy(dx: -radius, dy: -radius)) // 外部路径
        let innerPath = UIBezierPath(rect: object.bounds).reversing()                           // 内部路径
        outerPath.append(innerPath)                              // 反转内部路径并添加到外部路径
        
        // 将路径赋值给图层
        shadowLayer.path = outerPath.cgPath
        shadowLayer.masksToBounds = true
        // 添加阴影图层到视图的主图层
        object.layer.addSublayer(shadowLayer)
    }
    
    func removeInnerShadow() {
        // 查找并移除名为 "InnerShadowLayer" 的子图层
        object.layer.sublayers?.removeAll(where: { $0.name == "InnerShadowLayer" })
    }
    
    ///设置Frame
    func setFrame(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> Void {
        var frame = object.frame
        if let x = x {
            object.frame = CGRect(x: x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        }
        frame = object.frame
        if let y = y {
            object.frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: frame.size.height)
        }
        frame = object.frame
        if let width = width {
            object.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
        }
        frame = object.frame
        if let height = height {
            object.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
        }
    }

    func className() -> String {
        return String("\(type(of: object))")
    }

    static func className() -> String {
        return String("\(classObject.self)")
    }
}
