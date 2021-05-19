//
//  Date.swift
//  MiaoKiit
//
//  Created by miaokii on 2021/5/19.
//

import Foundation

public extension Date {
    
    init?(time: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        guard let date = formatter.date(from: time) else {
            return nil
        }
        self.init(timeInterval:0, since: date)
    }
    
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
}
    
