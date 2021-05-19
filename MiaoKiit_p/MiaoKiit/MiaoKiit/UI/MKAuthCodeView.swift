////
////  MKAuthCodeView.swift
////  MiaoKiit
////
////  Created by miaokii on 2021/5/19.
////
//
//import UIKit
//
//fileprivate class CodeField: UITextField {
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        return false
//    }
//}
//
///// 验证码视图
//class MKAuthcodeView: MKView {
//    
//    /// 验证码位数
//    var codeDigit: Int = 4
//    /// 验证码之间间距
//    var codeSpace: CGFloat = 10
//    /// 号码背景颜色
//    var codeNumBgColor: UIColor = .table_bg
//    /// 号码颜色
//    var codeNumColor = UIColor.text_l1
//    /// 字体
//    var codeFont = UIFont.boldSystemFont(ofSize: 20)
//    /// 圆角
//    var codeRadius: CGFloat = 3
//    /// 边框宽度
//    var codeBorderWidth: CGFloat = 0
//    /// 边框颜色
//    var codeBorderColor: UIColor = .clear
//    
//    /// 输入结束回调
//    var codeClosure: ((String)->Void)?
//    
//    var code: String {
//        get { return codeField.text ?? ""}
//        set {
//            codeField.text = newValue
//            (0..<codeDigit).forEach { i in
//                let label = self.viewWithTag(i+1) as! UILabel
//                if newValue.count == codeDigit {
//                    label.text = newValue[i..<i+1]
//                } else {
//                    label.text = ""
//                }
//            }
//        }
//    }
//    
//    private var inited = false
//    private var codeField: CodeField!
//    
//    override func setup() {
//        codeField = CodeField.init(super: self,
//                                   textColor: .clear,
//                                   tintColor: .clear,
//                                    backgroundColor: .clear,
//                                    keyboardType: .numberPad)
//        codeField.snp.makeConstraints({ $0.edges.equalTo(0) })
//        codeField.addTarget(self, action: #selector(codeFieldTextChanged), for: .editingChanged)
//        codeField.addTarget(self, action: #selector(codeFieldEditBegin), for: .editingDidBegin)
//        clipsToBounds = true
//    }
//    
//    @discardableResult override func becomeFirstResponder() -> Bool {
//        codeField.becomeFirstResponder()
//    }
//    
//    @objc private func codeFieldTextChanged() {
//        var codeString = codeField.text ?? ""
//        
//        /// 给每一个label设置值
//        for i in 0..<codeDigit {
//            let codeLabel = codeField.viewWithTag(i+1) as! UILabel
//            if i < codeString.count {
//                codeLabel.text = String.init(codeString[i])
//            } else {
//                codeLabel.text = ""
//            }
//        }
//        
//        /// 如果输入框超出了最大长度，就截取
//        if codeString.count >= codeDigit {
//            codeField.resignFirstResponder()
//            codeString = codeString[0..<codeDigit]
//            codeField.text = codeString
//            codeClosure?(codeString)
//        }
//    }
//    
//    @objc private func codeFieldEditBegin() {
//        codeField.text = ""
//        guard inited else {
//            return
//        }
//        /// 给每一个label设置值
//        for i in 0..<codeDigit {
//            let codeLabel = codeField.viewWithTag(i+1) as! UILabel
//            codeLabel.text = ""
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        for i in 0..<codeDigit {
//            let codeLabel = UILabel.init(super: codeField,
//                                         textColor: codeNumColor,
//                                         font: codeFont,
//                                         aligment: .center)
//            codeLabel.backgroundColor = codeNumBgColor
//            codeLabel.tag = i+1
//            if codeRadius > 0 {
//                codeLabel.layer.cornerRadius = codeRadius
//                codeLabel.clipsToBounds = true
//            }
//            codeLabel.layer.borderWidth = codeBorderWidth
//            codeLabel.layer.borderColor = codeBorderColor.cgColor
//            codeLabel.snp.makeConstraints { (make) in
//                make.centerY.centerY.equalToSuperview()
//                make.centerX.equalToSuperview().multipliedBy((CGFloat(i)*2+1)/CGFloat(codeDigit))
//                make.top.equalTo(5)
//                make.width.equalToSuperview().dividedBy(codeDigit).offset(-codeSpace)
//            }
//        }
//        inited = true
//    }
//}
