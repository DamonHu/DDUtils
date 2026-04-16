//
//  UIImageView+kingfisher.swift
//  DDUtils
//
//  Created by Damon on 2026/3/31.
//  Copyright © 2026 Damon. All rights reserved.
//

import Kingfisher

//PDF序列化
struct DDUtilsPDFProcessor: ImageProcessor {
    public var identifier: String {
        if let size = targetSize {
            return "ddutils.identifier.PDFProcessor(size:\(size.width)x\(size.height))"
        }
        return "ddutils.identifier.PDFProcessor.original"
    }
    private let targetSize: CGSize?
    public init(targetSize: CGSize? = nil) {
        self.targetSize = targetSize
    }
    
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image.withRenderingMode(.alwaysTemplate)
        case .data(let data):
            guard
                let provider: CGDataProvider = CGDataProvider(data: data as CFData),
                let pdfDoc: CGPDFDocument = CGPDFDocument(provider),
                let pdfPage: CGPDFPage = pdfDoc.page(at: 1)
            else { return nil }
            
            //原始尺寸
            var pageRect = pdfPage.getBoxRect(.artBox)
            if pageRect.isEmpty {
                pageRect = pdfPage.getBoxRect(.cropBox)
            }
            if pageRect.isEmpty {
                pageRect = pdfPage.getBoxRect(.mediaBox)
            }
            //目标尺寸
            let drawSize = targetSize ?? pageRect.size
            //矢量渲染
            let format = UIGraphicsImageRendererFormat()
            format.opaque = false
            format.scale = UIScreen.main.scale // 自动匹配屏幕像素倍数 (2x/3x)
            
            let renderer = UIGraphicsImageRenderer(size: drawSize, format: format)
            let img = renderer.image { ctx in
                let cgContext = ctx.cgContext
                cgContext.saveGState()
                //背景色测试
//                UIColor.red.withAlphaComponent(0.3).setFill()
//                ctx.fill(CGRect(origin: .zero, size: drawSize))
                // 3. 开启高质量渲染选项
                cgContext.interpolationQuality = .high
                cgContext.setAllowsAntialiasing(true)
                cgContext.setShouldAntialias(true)
                //内容翻转
                cgContext.translateBy(x: 0.0, y: drawSize.height)
                cgContext.scaleBy(x: 1, y: -1)
                // 3. 计算缩放比例 (比如 100 / 9 = 11.11倍)
                let scaleX = drawSize.width / pageRect.width
                let scaleY = drawSize.height / pageRect.height
                cgContext.scaleBy(x: scaleX, y: scaleY)
                // 如果 PDF 的原点不是 (0,0)，需要把原点移回来
                cgContext.translateBy(x: -pageRect.origin.x, y: -pageRect.origin.y)
                // 5. 绘制
                cgContext.drawPDFPage(pdfPage)
                ctx.cgContext.restoreGState()
            }
            return img.withRenderingMode(.alwaysTemplate)
        }
    }
}

struct PDFCacheSerializer: CacheSerializer {
    static let shared = PDFCacheSerializer()
    private init() {}
    
    // 从磁盘读取数据转成 Image 时触发
    func image(with data: Data, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        let image = KFCrossPlatformImage(data: data, scale: options.scaleFactor)
        return image?.withRenderingMode(.alwaysTemplate)
    }
    
    // 将 Image 转成 Data 存入磁盘时触发
    func data(with image: KFCrossPlatformImage, original: Data?) -> Data? {
        return image.pngData()
    }
}
