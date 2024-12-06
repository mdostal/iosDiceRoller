////
////  MainBoardView.swift
////  DiceRollingApp
////
////  Created by Mathew Dostal on 12/4/24.
////
//
import SwiftUI
//
struct MainBoardView: View {
    @StateObject private var diceSet = DiceSet()
    @State private var showDrawer = false
    @State private var showMenu = false
    @GestureState private var dragOffset: CGFloat = 0
    @State private var rollDice = false
    @State private var selectedDie: DieType = .D6
    @EnvironmentObject var appState: AppState // Access the AppState environment object
    
    var body: some View {
        ZStack {
            // Background
            Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
            // Menu button
            VStack {
                
                
                // Main content
                VStack {
                    HStack {
                        Button(action: { showDrawer.toggle() }) {
                            Image(systemName: "ellipsis.circle")
                                .padding()
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 4)
                        }
                        Spacer()
                        Button(action: { showMenu.toggle() }) {
                            Image(systemName: "gear")
                                .padding()
                                .background(Circle().fill(Color.white))
                                .shadow(radius: 4)
                        }
                    }
                    Spacer()
                }
                .padding()
                
                
                // Dice results display
                if !diceSet.results.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(diceSet.results.indices, id: \.self) { index in
                                let die = diceSet.results[index]
                                VStack {
                                    if DiceRenderMode.threeD == appState.renderMode{
                                        Dice3DView(rollDice: $rollDice, type: die.type)
                                            .frame(width: 200, height: 200)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(20)
                                            .overlay(
                                                Text("\(die.result)")
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                            )
                                    } else {
                                        FlatDiceView(type: die.type)
                                            .frame(width: 200, height: 200)
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(20)
                                            .overlay(
                                                Text("\(die.result)")
                                                    .font(.headline)
                                                    .foregroundColor(.white)
                                            )
                                    }
                                    //                                                                        dieShape(for: die.type)
                                    //                                                                            .fill(Color.blue)
                                    //                                                                            .frame(width: 50, height: 50)
                                    //                                                                            .overlay(
                                    //                                                                                Text("\(die.result)")
                                    //                                                                                    .font(.headline)
                                    //                                                                                    .foregroundColor(.white)
                                    //                                                                            )
                                    //                                                                            .shadow(radius: 4)
                                    //                                    Text("D\(die.type.rawValue)")
                                    //                                        .font(.caption)
                                    //                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
                
                // Roll button
                Button(action: rollDiceAction) {
                    Text("Roll")
                        .font(.title)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            
            
            // Drawer
            if showDrawer {
                DiceDrawerView(diceSet: diceSet, isOpen: $showDrawer)
                    .transition(.move(edge: .leading))
            }
            
            // Menu overlay
            if showMenu {
                MenuView(isOpen: $showMenu)
                    .transition(.opacity)
            }
        }.gesture(
            DragGesture()
                .updating($dragOffset, body: { value, state, _ in
                    state = value.translation.width
                })
                .onEnded { value in
                    if value.translation.width > 100 { // Swipe right to open
                        withAnimation { showDrawer = true }
                    } else if value.translation.width < -100 { // Swipe left to close
                        withAnimation { showDrawer = false }
                    }
                }
        )
        
    }
    
    private func rollDiceAction() {
        diceSet.rollDice()
    }
    
}

// Custom Notification
extension Notification.Name {
    static let drawerToggle = Notification.Name("drawerToggle")
}

