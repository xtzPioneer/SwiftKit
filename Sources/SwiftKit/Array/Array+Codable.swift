//
//  Array+Codable.swift
//  
//
//  Created by 张雄 on 2022/9/8.
//

import Foundation

extension Array: RawRepresentable where Element: Codable {
    
    /// 初始化
    /// - Parameter rawValue: 原始值
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else { return nil }
        self = result
    }
    
    /// 原始值
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
    
}
