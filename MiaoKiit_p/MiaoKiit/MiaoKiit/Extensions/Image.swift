//
//  Image.swift
//  MiaoKiit
//
//  Created by miaokii on 2021/5/19.
//

import UIKit

// MARK: - 创建
public extension UIImage {
    
    /// 使用主题色生成的照片
    static let theme = UIImage.init(color: .theme)
    
    /// 根据颜色生成图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 图片大小
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1.0, height: 1.0)){
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(CGRect.init(origin: CGPoint.zero, size: size))
        context?.setShouldAntialias(true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
    
    /// 缩放图片
    /// - Parameter size: 目的大小
    /// - Returns: 缩放后图片
    func scale(to size: CGSize) -> UIImage {
        // 获得原图像的 大小 宽  高
        let imageSize = self.size
        let width = imageSize.width
        let height = imageSize.height
        
        // 计算图像新尺寸与旧尺寸的宽高比例
        let widthFactor = size.width/width
        let heightFactor = size.height/height
        // 获取最小的比例
        let scalerFactor = (widthFactor < heightFactor) ? widthFactor : heightFactor
        
        // 计算图像新的高度和宽度，并构成标准的CGSize对象
        let scaledWidth = width * scalerFactor
        let scaledHeight = height * scalerFactor
        let targetSize = CGSize(width: scaledWidth, height: scaledHeight)
        
        // 创建绘图上下文环境
        UIGraphicsBeginImageContext(targetSize)
        self.draw(in: CGRect(x: 0, y: 0, width: scaledWidth, height: scaledHeight))
        
        // 获取上下文里的内容，将视图写入到新的图像对象
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        return newImage!
    }
}

// MARK: - 生成二维码或条形码
extension UIImage {
    
    /// 码类型
    enum QRType: String {
        case qrcode = "CIQRCodeGenerator"
        case barcode = "CICode128BarcodeGenerator"
    }
    
    /// 生成二维码或者条形码
    /// - Parameters:
    ///   - content: 码内容
    ///   - type: 码类型
    ///   - qrColor: ma颜色
    ///   - backColor: 码背景颜色
    ///   - size: 码的尺寸
    ///   - logo: logo图片，默认不添加，如果添加的话只有二维码会添加
    ///   - logoSize: logo尺寸
    /// - Returns: 生成的码
    static func createQr(_ content: String,
                         type: QRType = .qrcode,
                         qrColor: UIColor = .black,
                         backColor: UIColor = .white,
                         size: CGSize = .init(width: 200, height: 200),
                         logo: UIImage? = nil,
                         logoSize: CGSize = CGSize(width: 30, height: 30)) -> UIImage? {
        // 将字符串转出NSData
        let imageData = content.data(using: .utf8)!
        // 将字符串变成二维码滤镜
        let filter = CIFilter(name: type.rawValue)
        // 恢复滤镜的默认属性
        filter?.setDefaults()
        // 设置滤镜的 inputMessage
        filter?.setValue(imageData, forKey: "inputMessage")
        // 获得滤镜输出的图像
        guard let ciImage = filter?.outputImage else { return nil }
        
        // 创建颜色滤镜
        let colorFilter = CIFilter(name: "CIFalseColor")
        // 颜色滤镜默认属性
        colorFilter?.setDefaults()
        // 颜色滤镜图像
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        // 颜色滤镜颜色
        colorFilter?.setValue(CIColor.init(cgColor: qrColor.cgColor), forKey: "inputColor0")
        // 颜色滤镜背景
        colorFilter?.setValue(CIColor.init(cgColor: backColor.cgColor), forKey: "inputColor1")
        
        // 添加颜色滤镜后的图像
        guard let outputImage = colorFilter?.outputImage else {
            return nil
        }
        
        // 此时获得的二维码图片比较模糊，通过下面函数转换成高清
        let scaleX = size.width / outputImage.extent.width
        let scaleY = size.height / outputImage.extent.height
        let scaleImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        // 如果是条码或者不设置logo的二维码，就直接返回
        guard type == .qrcode, let logoImage = logo else { return UIImage(ciImage: scaleImage)}
        
        // 二维码图片
        let qrImage = UIImage(ciImage: scaleImage)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: .init(origin: .zero, size: size))
        logoImage.draw(in: .init(x: (size.width-logoSize.width)/2, y: (size.width-size.height)/2, width: logoSize.width, height: logoSize.height))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

// MARK: Tint Image
public extension UIImage {
    
    func tintTo(color: UIColor, blendModel: CGBlendMode = .destinationIn, alpha: CGFloat = 1.0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        color.setFill()
        UIRectFill(imageRect)
        self.draw(in: imageRect, blendMode: blendModel, alpha: alpha)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
