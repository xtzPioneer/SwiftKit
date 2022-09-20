//
//  FrameReader.swift
//  
//
//  Created by 张雄 on 2022/9/19.
//

import Foundation
import SwiftUI

/// 框架读取器
struct FrameReader: ViewModifier {
    
    /// 框架
    @Binding var frame: CGRect
    
    /// 安全区域
    @Binding var safeArea: EdgeInsets
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometryReader -> AnyView in
                    let rect = geometryReader.frame(in: .global)
                    if rect.integral != self.frame.integral {
                        DispatchQueue.main.async {
                            self.safeArea = geometryReader.safeAreaInsets
                            self.frame = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
    }
    
}

extension View {
    
    /// 框架读取器
    /// - Parameters:
    ///   - frame: 框架
    ///   - safeArea: 安全区域
    /// - Returns: View
    public func frameReader(_ frame: Binding<CGRect>, _ safeArea: Binding<EdgeInsets>) -> some View {
        modifier(FrameReader(frame: frame, safeArea: safeArea))
    }
    
}
