//
//  PublishedObject.swift
//  
//
//  Created by 张雄 on 2022/9/21.
//

import Foundation
import Combine

/// PublishedObject
///
/// Object
///
@propertyWrapper public struct PublishedObject<Value: ObservableObject> {
    
    /// 值
    public var wrappedValue: Value
    
    /// 订阅者
    private var subscription: AnyCancellable?
    
    // 官方建议的下标方法
    // https://github.com/apple/swift-evolution/blob/main/proposals/0258-property-wrappers.md#referencing-the-enclosing-self-in-a-wrapper-type
    public static subscript<OuterSelf: ObservableObject>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value where OuterSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
        get {
            if observed[keyPath: storageKeyPath].subscription == nil {
                observed[keyPath: storageKeyPath].bindSubscription(observed)
            }
            return observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            observed.objectWillChange.send()
            observed[keyPath: storageKeyPath].wrappedValue = newValue
        }
    }
    
    /// 绑定订阅
    /// - Parameter enclosingInstance: 封闭实例
    private mutating func bindSubscription<OuterSelf: ObservableObject>(_ enclosingInstance: OuterSelf) where OuterSelf.ObjectWillChangePublisher == ObservableObjectPublisher {
        subscription = wrappedValue.objectWillChange.sink(receiveValue: { [weak enclosingInstance] _ in
            DispatchQueue.main.async { (enclosingInstance?.objectWillChange)?.send() }
        })
    }
    
    /// 初始化
    /// - Parameter wrappedValue: 值
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
    
}
