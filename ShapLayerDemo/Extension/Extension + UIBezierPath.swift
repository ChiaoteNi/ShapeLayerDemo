//
//  Extesion + UIBezierPath.swift
//  GradientDemo
//
//  Created by Chiao-Te Ni on 2018/6/11.
//  Copyright © 2018年 aaron. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath {
    
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        // 先移到最底部
        self.move(to: CGPoint(x: rect.width * 0.5, y: rect.height))
        
        let topLeftPt: CGPoint = CGPoint(x: rect.width * 0.15,
                                         y: -rect.height * 0.2)
        let leftPt: CGPoint = CGPoint(x: -(rect.width * 0.35),
                                      y: (rect.height * 0.55))
        
        // 網上畫到愛心下凹處
        self.addCurve(to: CGPoint(x: rect.width * 0.5,
                                  y: rect.height * 0.25),
                      controlPoint1: leftPt,
                      controlPoint2: topLeftPt)
        
        // 再往下畫回愛心的底部
        self.addCurve(to: CGPoint(x: rect.width * 0.5, y: rect.height),
                      controlPoint1: CGPoint(x: rect.width - topLeftPt.x,
                                             y: topLeftPt.y),
                      controlPoint2: CGPoint(x: rect.width - leftPt.x,
                                             y: leftPt.y))
        self.close()
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
