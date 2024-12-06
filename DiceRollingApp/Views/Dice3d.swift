//
//  Dice3d.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/5/24.
//

import Foundation
import SceneKit
import SwiftUI

// 4 sided
extension SCNGeometry {
    static func SCNTetrahedron(size: CGFloat) -> SCNGeometry {
        let h = size * sqrt(2.0 / 3.0) // Height of the tetrahedron

        let vertices: [SCNVector3] = [
            SCNVector3(0, h / 2, 0), // Top vertex
            SCNVector3(-size / 2, -h / 2, -size / sqrt(3)), // Base left
            SCNVector3(size / 2, -h / 2, -size / sqrt(3)), // Base right
            SCNVector3(0, -h / 2, size / sqrt(3)) // Base front
        ]

        let indices: [Int32] = [
            0, 1, 2, // Front face
            0, 2, 3, // Right face
            0, 3, 1, // Left face
            1, 2, 3  // Base face
        ]

        let vertexSource = SCNGeometrySource(vertices: vertices)
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)

        return SCNGeometry(sources: [vertexSource], elements: [element])
    }
}

// 6 sided
extension SCNGeometry {
    static func SCNCube(size: CGFloat) -> SCNGeometry {
        return SCNBox(width: size, height: size, length: size, chamferRadius: 0.1)
    }
}

// 8 sided
extension SCNGeometry {
    static func SCNOctahedron(size: CGFloat) -> SCNGeometry {
        // Define vertices for the octahedron
        let vertices: [SCNVector3] = [
            SCNVector3(0, size, 0),   // Top
            SCNVector3(size, 0, 0),  // Right
            SCNVector3(0, 0, size),  // Front
            SCNVector3(-size, 0, 0), // Left
            SCNVector3(0, 0, -size), // Back
            SCNVector3(0, -size, 0)  // Bottom
        ]

        // Define indices for the triangles
        let indices: [Int32] = [
            0, 1, 2, // Top-front-right
            0, 2, 3, // Top-front-left
            0, 3, 4, // Top-back-left
            0, 4, 1, // Top-back-right
            5, 2, 1, // Bottom-front-right
            5, 3, 2, // Bottom-front-left
            5, 4, 3, // Bottom-back-left
            5, 1, 4  // Bottom-back-right
        ]

        // Convert vertices into a geometry source
        let vertexSource = SCNGeometrySource(vertices: vertices)

        // Convert indices into a geometry element
        let element = SCNGeometryElement(
            indices: indices,
            primitiveType: .triangles
        )

        // Create and return the geometry
        return SCNGeometry(sources: [vertexSource], elements: [element])
    }
}

//10 sided
extension SCNGeometry {
    static func SCNPentagonalTrapezohedron(size: CGFloat) -> SCNGeometry {
        // Approximate vertices and faces for D10
        // This requires manual modeling or a prebuilt 3D model.
        return SCNSphere(radius: size / 2) // Placeholder for simplicity
    }
}

// 12 sided

extension SCNGeometry {
    static func SCNDodecahedron(size: CGFloat) -> SCNGeometry {
        // Approximate vertices and faces for D12
        // This requires more complex calculations or a prebuilt model.
        return SCNSphere(radius: size / 2) // Placeholder for simplicity
    }
}

// 20 sided
extension SCNGeometry {
    static func SCNIcosahedron(size: CGFloat) -> SCNGeometry {
        let t = (1.0 + sqrt(5.0)) / 2.0 // Golden ratio

        // Define vertices without scaling
        let rawVertices: [SCNVector3] = [
            SCNVector3(-1, t, 0), SCNVector3(1, t, 0), SCNVector3(-1, -t, 0), SCNVector3(1, -t, 0),
            SCNVector3(0, -1, t), SCNVector3(0, 1, t), SCNVector3(0, -1, -t), SCNVector3(0, 1, -t),
            SCNVector3(t, 0, -1), SCNVector3(t, 0, 1), SCNVector3(-t, 0, -1), SCNVector3(-t, 0, 1)
        ].map { vertex in
            SCNVector3(
                Float(vertex.x),
                Float(vertex.y),
                Float(vertex.z)
            )
        }

        // Apply scaling factor to each vertex
        let vertices = rawVertices.map { vertex in
            SCNVector3(
                x: vertex.x * Float(size),
                y: vertex.y * Float(size),
                z: vertex.z * Float(size)
            )
        }

        // Define indices for 20 triangular faces of the icosahedron
        let indices: [Int32] = [
            0, 11, 5, 0, 5, 1, 0, 1, 7, 0, 7, 10, 0, 10, 11,
            1, 5, 9, 5, 11, 4, 11, 10, 2, 10, 7, 6, 7, 1, 8,
            3, 9, 4, 3, 4, 2, 3, 2, 6, 3, 6, 8, 3, 8, 9,
            4, 9, 5, 2, 4, 11, 6, 2, 10, 8, 6, 7, 9, 8, 1
        ]

        // Convert vertices into a geometry source
        let vertexSource = SCNGeometrySource(vertices: vertices)

        // Convert indices into a geometry element
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)

        // Create and return the geometry
        return SCNGeometry(sources: [vertexSource], elements: [element])
    }
}
