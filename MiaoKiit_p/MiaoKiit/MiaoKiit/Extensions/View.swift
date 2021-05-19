//
//  View.swift
//  MiaoKiit
//
//  Created by miaokii on 2021/5/19.
//

import UIKit

// MARK: - 复用id
extension UIView {
    /// 复用id
    static var reuseID: String {
        return String.init(describing: Self.self)
    }
}

class MKView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {}
    func set(model: Any) {}
}

// MARK: - round
public extension UIView {
    /// 切圆角，确定frame后调用
    /// - Parameters:
    ///   - corners: 要切的角
    ///   - radius: 圆角值
    func round(corners: UIRectCorner = UIRectCorner.allCorners, radius: CGFloat = -1) {
        let r = radius == -1 ? min(frame.width, frame.height) / 2 : radius
        round(corners: corners, size: CGSize.init(width: r, height: r))
    }
    
    /// 切圆角，确定frame后调用
    /// - Parameters:
    ///   - corners: 要切的角
    ///   - size: 圆角值
    func round(corners: UIRectCorner = UIRectCorner.allCorners, size: CGSize) {
        layer.mask = nil
        let bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: size)
        defer {
            bezierPath.close()
        }
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
}

// MARK: - frame信息
public extension UIView {
    
    var height:CGFloat {
        get {
            return frame.height
        }
        set(newValue){
            var tempFrame = self.frame
            tempFrame.size.height = newValue
            self.frame = tempFrame
        }
    }
    
    var width:CGFloat {
        get{
            return frame.width
        }
        
        set(newValue){
            var tempFrame = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    var centerX:CGFloat {
        get{
            return center.x
        }
        set(newValue){
            var tempCenter = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    var centerY:CGFloat {
        get{
            return center.y
        }
        set(newValue){
            var tempCenter = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    /// left值
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    /// top值
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    /// right值
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set {
            var tempFrame = frame
            tempFrame.origin.x = newValue - frame.size.width
            frame = tempFrame
        }
    }
    
    /// bottom值
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set {
            var tempFrame = frame
            tempFrame.origin.y = newValue - frame.size.height
            frame = tempFrame
        }
    }
    
    /// size值
    var size: CGSize {
        get {
            return frame.size
        }
        set {
            var tempFrame = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// origin值
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var tempFrame = frame
            tempFrame.origin = newValue
            frame = tempFrame
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    var borderColor: UIColor? {
        get {
            return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var shadowColor: UIColor? {
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
}
