//
//  MenuView.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//
import SwiftUI

struct MenuView: View {
    @Binding var isOpen: Bool
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Settings")
                .font(.headline)
                .padding(.top)

            // Render Mode Picker
            Picker("Render Mode", selection: $appState.renderMode) {
                Text("3D Dice").tag(DiceRenderMode.threeD)
                Text("2D Shapes").tag(DiceRenderMode.flat)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            Button("Close Menu") {
                isOpen = false
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.6))
        .edgesIgnoringSafeArea(.all)
    }
}
