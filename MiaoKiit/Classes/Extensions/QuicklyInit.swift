//
//  QuicklyInit.swift
//  MiaoKiit
//
//  Created by miaokii on 2021/5/19.
//

import UIKit

public extension UILabel {
    convenience init(super view: UIView?,
                     text: String = "",
                     textColor: UIColor = .text_l1,
                     font: UIFont = .systemFont(ofSize: 15),
                     aligment: NSTextAlignment = .left,
                     numLines: Int = 0) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.font = font
        self.textAlignment = aligment
        self.numberOfLines = numLines
        self.text = text
        
        if let sview = view {
            sview.addSubview(self)
        }
    }
}

public extension UIButton {
    convenience init(super view: UIView?,
                     title: String = "",
                     titleColor: UIColor = .text_l1,
                     backgroundColor: UIColor? = nil,
                     font: UIFont = .systemFont(ofSize: 17),
                     normalImage: UIImage? = nil,
                     selectedImage: UIImage? = nil,
                     backgroundImage: UIImage? = nil,
                     highlightBackgroundImage: UIImage? = nil,
                     borderWidth: CGFloat = 0,
                     borderColor: UIColor? = nil,
                     cornerRadius: CGFloat = 0,
                     clipsToBounds: Bool = false,
                     target_selector: (Any, Selector)? = nil) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.setImage(normalImage, for: .normal)
        self.setImage(selectedImage, for: .selected)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(highlightBackgroundImage, for: .highlighted)
        self.backgroundColor = backgroundColor
        
        if let (target, selector) = target_selector {
            self.addTarget(target, action: selector, for: .touchUpInside)
        }
        
        if borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        
        if let bcolor = borderColor {
            self.layer.borderColor = bcolor.cgColor
        }
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
        self.clipsToBounds = clipsToBounds
        
        if let sview = view {
            sview.addSubview(self)
        }
    }
    
    static func theme(super view: UIView?,
                      title: String,
                      titleColor: UIColor = .white,
                      font: UIFont = .systemFont(ofSize: 17),
                      backgroundImage: UIImage = .theme,
                      cornerRadius: CGFloat = 5,
                      target_selector: (Any, Selector)? = nil) -> UIButton {
        let btn = UIButton.init(super: view,
                                title: title,
                                titleColor: titleColor,
                                font: font,
                                backgroundImage: backgroundImage,
                                cornerRadius: cornerRadius,
                                clipsToBounds: true,
                                target_selector: target_selector)
        return btn
    }
    
    static func themeBorder(super view: UIView?,
                            title: String,
                            font: UIFont = .systemFont(ofSize: 16),
                            borderWidth: CGFloat = 1,
                            borderColor: UIColor = .theme,
                            cornerRadius: CGFloat = 5,
                            target_selector: (Any, Selector)? = nil) -> UIButton {
        let btn = UIButton.init(super: view,
                                title: title,
                                titleColor: .theme,
                                font: font,
                                borderWidth: borderWidth,
                                borderColor: borderColor,
                                cornerRadius: cornerRadius,
                                target_selector: target_selector)
        return btn
    }
}

public extension UIImageView {
    convenience init(super view: UIView?,
                     image: UIImage? = nil,
                     contentMode: ContentMode = .scaleAspectFill,
                     cornerRadius: CGFloat = 0) {
        self.init(image: image)
        self.contentMode = contentMode
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
        
        if let sview = view {
            sview.addSubview(self)
        }
    }
}

public extension UIView {
    
    convenience init(super view: UIView?,
                     backgroundColor: UIColor = .view_l1,
                     cornerRadius: CGFloat = 0) {
        self.init()
        self.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
        }
        
        if let sview = view {
            sview.addSubview(self)
        }
    }
    
    var controller: UIViewController? {
        get {
            var nextResponder: UIResponder?
            nextResponder = next
            repeat {
                if nextResponder is UIViewController {
                    return (nextResponder as! UIViewController)
                } else {
                    nextResponder = nextResponder?.next
                }
            } while nextResponder != nil
            return nil
        }
    }
    
    /// ????????????
    /// - Parameters:
    ///   - color: ??????????????????????????????
    ///   - radius: ??????????????????????????????5??????????????????0????????????????????????????????????????????????????????????????????????
    ///   ??????????????????????????????????????????????????????????????????????????????
    ///   - offset: ???????????????????????????CGSize??????????????????????????????????????????????????????????????????????????????(4???4)
    ///   ?????????????????????????????????4?????????????????????????????????4
    ///   - opacity: ????????? 0-1?????????0.2
    func setShadow(color: UIColor = .gray,
                   radius: CGFloat = 5,
                   offset: CGSize = .init(width: 4, height: 4),
                   opacity: Float = 0.2) {
        
        guard frame.size != .zero else {
            return
        }
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity

        // ??????????????????
        layer.shadowPath = UIBezierPath.init(roundedRect: bounds, cornerRadius: radius).cgPath
    }
}

public extension UITextField {
    
    var isEmpty: Bool {
        return (self.text ?? "").isEmpty
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    convenience init(super view: UIView?,
                     text: String = "",
                     textColor: UIColor = .text_l1,
                     attributedText: NSAttributedString? = nil,
                     font: UIFont = .systemFont(ofSize: 15),
                     placeHolder: String = "",
                     attributedPlaceholder: NSAttributedString? = nil,
                     aligment: NSTextAlignment = .left,
                     tintColor: UIColor = .blue,
                     backgroundColor: UIColor? = .view_l1,
                     delegate: UITextFieldDelegate? = nil,
                     keyboardType: UIKeyboardType = .default,
                     borderStyle: BorderStyle = .none,
                     borderWidth: CGFloat = 0,
                     borderColor: UIColor? = nil,
                     cornerRadius: CGFloat = 0) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.placeholder = placeHolder
        self.font = font
        self.textAlignment = aligment
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.delegate = delegate
        self.keyboardType = keyboardType
        self.borderStyle = borderStyle
        
        if let attributedPlace = attributedPlaceholder {
            self.attributedPlaceholder = attributedPlace
        }
        
        if let attributed = attributedText {
            self.attributedText = attributed
        }
        
        if borderWidth > 0 {
            self.layer.borderWidth = borderWidth
        }
        
        if let bcolor = borderColor {
            self.layer.borderColor = bcolor.cgColor
        }
        
        if cornerRadius > 0 {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = clipsToBounds
        }
        
        if let sview = view {
            sview.addSubview(self)
        }
    }
}
