//
//  String.swift
//  MiaoKiit
//
//  Created by miaokii on 2021/5/19.
//

import Foundation

// MARK: - 格式化 数字->字符串
public extension String {
    
    /// 格式化货币金额
    /// - Parameters:
    ///   - value: 金额值
    /// - Returns: 格式化后的值
    static func price(for value: Double) -> String {
        return .number(for: value, style: .currency, maxDigits: 2, minDigits: 0)
    }
        
    /// 格式化货币，不显示货币符号
    /// - Parameter value: 金额值
    /// - Returns: 格式化结果
    static func priceWithoutSymbol(value: Double) -> String {
        return .number(for: value, style: .decimal, maxDigits: 2, minDigits: 0)
    }
    
    /// 将Double格式化数字
    /// - Parameters:
    ///   - value: 数值
    ///   - style: 数值类型
    ///   - maxDigits: 小数点后最多位
    ///   - minDigits: 小数点后最小位数
    /// - Returns: 格式化结果
    static func number(for value: Double, style: NumberFormatter.Style = .none, maxDigits: Int = 2, minDigits: Int = 1) -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.locale = .current
        
        return formatter.string(from: NSNumber.init(value: value)) ?? ""
    }
    
    /// 将Double格式化数字
    /// - Parameters:
    ///   - value: 数值
    ///   - configFormatter: 自定义配置
    /// - Returns: 格式化结果
    static func number(for value: Double, configFormatter: (NumberFormatter)->Void) -> String {
        let formatter = NumberFormatter.init()
        configFormatter(formatter)
        return formatter.string(from: NSNumber.init(value: value)) ?? ""
    }
}

// MARK: - 下标访问
extension String {
    subscript(offset: Int) -> Character {
        get {
            return self[index(startIndex, offsetBy: offset)]
        }
        set {
            replaceSubrange(index(startIndex, offsetBy: offset)..<index(startIndex, offsetBy: offset + 1), with: [newValue])
        }
    }
    
    subscript(range: CountableRange<Int>) -> String {
        get {
            return String(self[index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound)])
        }
        set {
            replaceSubrange(index(startIndex, offsetBy: range.lowerBound)..<index(startIndex, offsetBy: range.upperBound), with: newValue)
        }
    }
    
    subscript(location: Int, length: Int) -> String {
        get {
            return String(self[index(startIndex, offsetBy: location)..<index(startIndex, offsetBy: location + length)])
        }
        set {
            replaceSubrange(index(startIndex, offsetBy: location)..<index(startIndex, offsetBy: location + length), with: newValue)
        }
    }
}
