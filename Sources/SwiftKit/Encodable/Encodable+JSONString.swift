//
//  Encodable+JSONString.swift
//  
//
//  Created by 张雄 on 2022/9/23.
//

import Foundation

extension Encodable {
    
    /// 转换至JSON
    /// - Returns: JSON
    public func toJSONString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self) else { return "" }
        guard let jsonString = String(data: data, encoding: .utf8) else { return "" }
        return jsonString
    }
    
}
