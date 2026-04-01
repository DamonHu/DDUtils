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
    let identifier = "ddutils.identifier.PDFProcessor"
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

            let pageRect = pdfPage.getBoxRect(.mediaBox)
            let format = UIGraphicsImageRendererFormat()
            format.opaque = false
                        
            let renderer = UIGraphicsImageRenderer(size: pageRect.size, format: format)
            let img = renderer.image { ctx in
                ctx.cgContext.saveGState()
                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                let transform = pdfPage.getDrawingTransform(.mediaBox, rect: pageRect, rotate: 0, preserveAspectRatio: true)
                ctx.cgContext.concatenate(transform)
                ctx.cgContext.drawPDFPage(pdfPage)
                ctx.cgContext.restoreGState()
            }
            return img.withRenderingMode(.alwaysTemplate)
        }
    }
}

struct PDFCacheSerializer: CacheSerializer {
    static let shared = PDFCacheSerializer()
    
    // 从磁盘读取数据转成 Image 时触发
    func image(with data: Data, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        let image = DefaultCacheSerializer.default.image(with: data, options: options)
        // 强制带上 Template 模式返回给 Kingfisher
        return image?.withRenderingMode(.alwaysTemplate)
    }
    
    // 将 Image 转成 Data 存入磁盘时触发
    func data(with image: KFCrossPlatformImage, original: Data?) -> Data? {
        return DefaultCacheSerializer.default.data(with: image, original: original)
    }
}
