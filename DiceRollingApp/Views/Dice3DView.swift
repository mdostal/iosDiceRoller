////
////  Dice3DView.swift
////  DiceRollingApp
////
////  Created by Mathew Dostal on 12/5/24.
////

import SwiftUI
import Foundation
import SceneKit

struct Dice3DView: UIViewRepresentable {
    @Binding var rollDice: Bool
    var type: DieType

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = createScene(for: type)
        sceneView.allowsCameraControl = false
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if rollDice {
            let diceNode = uiView.scene?.rootNode.childNode(withName: "dice", recursively: true)
            diceNode?.runAction(createRollAction())
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                rollDice = false // Reset roll state after animation
            }
        }
    }

    private func createScene(for type: DieType) -> SCNScene {
        let scene = SCNScene()

        // Add dice node
        let diceNode = createDiceNode(for: type)
        diceNode.name = "dice"
        scene.rootNode.addChildNode(diceNode)

        // Add camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 5, 10)
        cameraNode.look(at: SCNVector3(0, 0, 0))
        scene.rootNode.addChildNode(cameraNode)

        return scene
    }

    private func createDiceNode(for type: DieType) -> SCNNode {
        let diceNode: SCNNode
        switch type {
        case .D4:
            diceNode = SCNNode(geometry: SCNPyramid(width: 2, height: 2, length: 2))
        case .D6:
            diceNode = SCNNode(geometry: SCNBox(width: 2, height: 2, length: 2, chamferRadius: 0.2))
        case .D8:
            diceNode = SCNNode(geometry: SCNGeometry.SCNOctahedron(size: 2))
        case .D10:
            diceNode = SCNNode(geometry: SCNGeometry.SCNDodecahedron(size: 2)) // Approximation
        case .D12:
            diceNode = SCNNode(geometry: SCNGeometry.SCNDodecahedron(size: 2))
        case .D20:
            diceNode = SCNNode(geometry: SCNGeometry.SCNIcosahedron(size: 2))
        }
        // TODO: add color
//        diceNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        diceNode.position = SCNVector3(0, 0, 0)
        return diceNode
    }

    private func createRollAction() -> SCNAction {
        let xRotation = CGFloat.random(in: 2...6) * .pi
        let yRotation = CGFloat.random(in: 2...6) * .pi
        let zRotation = CGFloat.random(in: 2...6) * .pi
        return SCNAction.rotateBy(x: xRotation, y: yRotation, z: zRotation, duration: 2.0)
    }
}
