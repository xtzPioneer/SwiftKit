//
//  Array+FilterDuplicates.swift
//  
//
//  Created by 张雄 on 2022/9/8.
//

import Foundation

extension Array {
    
    /// 过滤重复
    /// - Parameter filter: 过滤
    /// - Returns: 过滤后的数组
    public func filterDuplicates<T: Equatable>(_ filter: (Element) -> T) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({ filter($0) }).contains(key) { result.append(value) }
        }
        return result
    }
    
}
