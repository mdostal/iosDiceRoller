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

    var body: some View {
        ZStack {
            // Background
            Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            // Main content
            VStack {
                Spacer()
                
                // Dice results display
                if !diceSet.results.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 20) {
                                                ForEach(diceSet.results.indices, id: \.self) { index in
                                                    let die = diceSet.results[index]
                                                    VStack {
                                                        dieShape(for: die.type)
                                                            .fill(Color.blue)
                                                            .frame(width: 50, height: 50)
                                                            .overlay(
                                                                Text("\(die.result)")
                                                                    .font(.headline)
                                                                    .foregroundColor(.white)
                                                            )
                                                            .shadow(radius: 4)
                                                        Text("D\(die.type.rawValue)")
                                                            .font(.caption)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                            }
                                            .padding()
                                        }
//                    HStack {
//                        ForEach(diceSet.results, id: \.result) { die in
//                            Text("\(die.result)")
//                                .font(.largeTitle)
//                                .padding()
//                                .background(Circle().fill(Color.white))
//                        }
//                    }
//                    .transition(.opacity)
                }

                // Roll button
                Button(action: rollDice) {
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
            .gesture(
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

            // Drawer
            if showDrawer {
                DiceDrawerView(diceSet: diceSet, isOpen: $showDrawer)
                    .transition(.move(edge: .leading))
            }

            // Menu button
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

            // Menu overlay
            if showMenu {
                MenuView(isOpen: $showMenu)
                    .transition(.opacity)
            }
        }.onReceive(NotificationCenter.default.publisher(for: .drawerToggle)) { _ in
            withAnimation {
                showDrawer.toggle()
            }
        }
    }

    private func rollDice() {
        diceSet.rollDice()
    }
    
}

// Custom Notification
extension Notification.Name {
    static let drawerToggle = Notification.Name("drawerToggle")
}

