//
//  MenuView.swift
//  DiceRollingApp
//
//  Created by Mathew Dostal on 12/4/24.
//
import SwiftUI

struct MenuView: View {
    @Binding var isOpen: Bool

    var body: some View {
        VStack {
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
