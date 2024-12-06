////
////  FlatDiceView.swift
////  DiceRollingApp
////
////  Created by Mathew Dostal on 12/5/24.
////
//
//import Foundation
//import SwiftUI
//struct FlatDiceView: View {
//    var die: DieType
//    var result: Int
//
//    var body: some View {
//        VStack {
//            dieShape(for: die)
//                .fill(Color.blue)
//                .frame(width: 50, height: 50)
//                .overlay(
//                    Text("\(result)")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                )
//                .shadow(radius: 4)
//            Text("D\(die.rawValue)")
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//    }
//
//    struct AnyShape: Shape {
//        private let _path: (CGRect) -> Path
//
//        init<S: Shape>(_ shape: S) {
//            self._path = shape.path(in:)
//        }
//
//        func path(in rect: CGRect) -> Path {
//            _path(rect)
//        }
//    }
//    func dieShape(for type: DieType) -> AnyShape {
//        switch type {
//        case .D4:
//            return AnyShape(Triangle())
//        case .D6:
//            return AnyShape(RoundedRectangle(cornerRadius: 8)) // Simple cube
//        case .D8:
//            return AnyShape(Octagon())
//        case .D10:
//            return AnyShape(Pentagon())
//        case .D12:
//            return AnyShape(Dodecagon())
//        case .D20:
//            return AnyShape(Dodecagon()) // D20 uses the same dodecagon for simplicity
//        }
//    }
//
//}
import SwiftUI

struct FlatDiceView: View {
    var type: DieType // The type of die to display (D4, D6, etc.)
    var rollResult: Int? = nil // Optional roll result to display on the die

    var body: some View {
        ZStack {
            // Die shape based on its type
            dieShape(for: type)
                .fill(Color.blue.opacity(0.8)) // Base color
                .overlay(dieShape(for: type).stroke(Color.white, lineWidth: 2)) // Border
                .shadow(radius: 4)
            
            // Roll result (optional)
            if let rollResult = rollResult {
                Text("\(rollResult)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            } else {
                Text(type.displayName)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 100, height: 100) // Set default size
    }
    
    struct AnyShape: Shape {
        private let _path: (CGRect) -> Path

        init<S: Shape>(_ shape: S) {
            _path = shape.path(in:)
        }

        func path(in rect: CGRect) -> Path {
            _path(rect)
        }
    }


    // Define shapes for different dice types
    private func dieShape(for type: DieType) -> AnyShape {
        switch type {
        case .D4:
            return AnyShape(Triangle())
        case .D6:
            return AnyShape(RoundedRectangle(cornerRadius: 8))
        case .D8:
            return AnyShape(Octagon())
        case .D10:
            return AnyShape(Pentagon())
        case .D12:
            return AnyShape(Dodecagon())
        case .D20:
            return AnyShape(Dodecagon()) // Reuse Dodecagon for simplicity
        }
    }
}

// Helper to define a triangle shape (D4)
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

// Helper to define an octagon shape (D8)
struct Octagon: Shape {
    func path(in rect: CGRect) -> Path {
        let inset = rect.width * 0.2
        return Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.minY + inset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX - inset, y: rect.maxY - inset))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + inset, y: rect.maxY - inset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX + inset, y: rect.minY + inset))
            path.closeSubpath()
        }
    }
}

// Helper to define a pentagon shape (D10)
struct Pentagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let points = stride(from: 0.0, to: 360.0, by: 72.0).map {
                CGPoint(
                    x: rect.midX + rect.width / 2 * CGFloat(cos($0 * .pi / 180)),
                    y: rect.midY + rect.height / 2 * CGFloat(sin($0 * .pi / 180))
                )
            }
            path.addLines(points)
            path.closeSubpath()
        }
    }
}

// Helper to define a dodecagon shape (D12/D20)
struct Dodecagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let inset = rect.width * 0.1
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
