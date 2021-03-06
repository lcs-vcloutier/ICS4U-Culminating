//
//  ContentView.swift
//  CulminatingApp
//
//  Created by Vincent Cloutier on 2022-05-31.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm: NodesList
    @State var activeNode = 0
    @State private var showingSheet = false
    @State var gameIsOn = false

    var currentNode: Node {
        return vm.findNode(with: activeNode)
    }
    
    // MARK: Initializer
    init (vm: NodesList) {
        self.vm = vm
    }
    
    // MARK: View
    var body: some View {
        if gameIsOn == false && activeNode == 0 {
            VStack {
                HStack {
                    Spacer()
                    if !vm.completedEndings.isEmpty {
                        Button {
                            showingSheet.toggle()
                        } label: {
                            Image(systemName: "clock.fill")
                                .font(Font.title)
                        }
                        .foregroundColor(.black)
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.vertical)
                
                Text("THE ABOMINABLE SNOWMAN")
                    .font(Font.custom("Benecarlo Book", size: 36))
                    .multilineTextAlignment(.center)
                
                Image("Cover")
                    .resizable()
                    .scaledToFit()
                    .border(Color.black, width: 10)
                    .padding()
                    .onTapGesture {
                        startGame()
                    }
                
                Text("BY R. A. MONTGOMERY")
                    .font(Font.custom("Benecarlo Medium", size: 24.0))
                
                Spacer()
                
            }
            .padding()
            .background(
                Image("Beige")
                    .resizable()
                    .ignoresSafeArea()
            )
            
            .sheet(isPresented: $showingSheet) {
                HistoryView(activeNode: $activeNode, vm: vm)
            }
        } else {

            NodeView(vm: vm, node: currentNode, gameIsOn: $gameIsOn, activeNode: $activeNode)
        }
    }
    func startGame() {
        if vm.activeNodeIndex > 0 {
            self.activeNode = vm.activeNodeIndex
            print("Game data retrieved, active node is \(self.activeNode)")
        } else {
            self.activeNode = 1
            vm.activeNodeIndex = activeNode
        }
        vm.saveIndex()
        gameIsOn = true
    }
}

