//
//  DieShapes.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//

import SwiftUI
import SceneKit


// Custom shapes for each die type

// Add D2
//struct Circle: Shape {
//    func path(in rect: CGRect) -> Path {
//        Path { path in
//            path
//        }
//    }
//}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct Octagon: Shape {
    func path(in rect: CGRect) -> Path {
        let inset = rect.width * 0.2
        return Path { path in
            path.move(to: CGPoint(x: rect.minX + inset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + inset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - inset))
            path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + inset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - inset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + inset))
            path.closeSubpath()
        }
    }
}

struct Pentagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY * 0.8))
            path.addLine(to: CGPoint(x: rect.maxX * 0.8, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX * 1.2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.8))
            path.closeSubpath()
        }
    }
}

struct Dodecagon: Shape {
    func path(in rect: CGRect) -> Path {
        let inset = rect.width * 0.1
        return Path { path in
            let points = stride(from: 0.0, to: 360.0, by: 30.0).map {
                CGPoint(
                    x: rect.midX + (rect.width / 2 - inset) * CGFloat(cos($0 * .pi / 180)),
                    y: rect.midY + (rect.height / 2 - inset) * CGFloat(sin($0 * .pi / 180))
                )
            }
            path.addLines(points)
            path.closeSubpath()
        }
    }
}
