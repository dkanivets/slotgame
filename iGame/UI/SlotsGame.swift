//
//  SlotsGame.swift
//  iGame
//
//  Created by Dmitry Kanivets on 16.02.2024.
//

import SwiftUI

struct SlotsGame: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var slots: [[String]] = []
//    @State private var animated = false
//    @State private var animation = 1.0
    @State private var coins: Int = 1000
    @State private var bet: Int = 50
    @State private var win: Int = 0
    @State private var showAlert = false
    private let baseSet = (1...7).map { "ic_slot_\($0)" }

    var body: some View {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    navigationButtons
                    Spacer()
                    BottomView(coins: $coins, bet: $bet, win: $win, betStep: 10, action: {
                        spin()
                    })
                }
                .background(
                    Image("ic_slots_bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .ignoresSafeArea(.all)
                slotMachineView
                    .ignoresSafeArea(.all)
            }
            .navigationBarHidden(true)
            .onAppear(perform: {
                slots = (1...5).map { _ in baseSet.shuffled() }
            })
        .ignoresSafeArea(.all)
        .sheet(isPresented: $showAlert, content: {
            WinAlertView(showModal: $showAlert)
        })
    }
    
    private var slotMachineView: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                HStack(alignment: .center, spacing: 16) {
                    ForEach(slots, id: \.self) { slot in
                        ScrollViewReader { scrollProxy in
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .center, spacing: 16) {
                                    ForEach(slot, id: \.self) { item in
                                        Image(item)
                                            .resizable()
                                            .frame(width: geometry.size.height / 5,
                                                   height: geometry.size.height / 5)
                                    }
                                }
                            }
                            .frame(height: (geometry.size.height / 5 + 16) * 3)
                        }
                    }
                }
                .padding(.top, geometry.size.height / 6)
                .clipped()
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(
                Image("ic_slots_frame")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            )
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 96)
        .padding(.top, 16)
        .padding(.bottom, 66)
        .clipped()
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 0) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("ic_back")
            })
            Spacer()
            NavigationLink(destination: {
                SettingsView()
            }, label: {
                Image("ic_settings")
            })
        }
        .padding(32)
    }
    
    private func calculateWin(with result: Int) {
        var resultToCoins: Int {
            switch result {
            case 1:
                return bet * 10
            case 2:
                return bet * 5
            case 3:
                return bet * 2
            case 4:
                return bet / 2
            default:
                return 0
            }
        }
        win = resultToCoins
        coins = coins + resultToCoins
    }
    
    private func spin() {
        /// Spin via shuffle
//        withAnimation(.linear) {
//            coins -= bet
//            slots = (1...5).map { _ in baseSet.shuffled() }
//            let result = Set(slots.map{$0[1]}).count
//            calculateWin(with: result)
//        }
        /// Spin via random shift
        withAnimation(.interpolatingSpring, {
            coins -= bet
            for slot in slots.enumerated() {
                slots[slot.offset] = slot.element.shift(withDistance: Int.random(in: 0...6) )
            }
            let result = Set(slots.map{$0[1]}).count
            calculateWin(with: result)
        }, completion: {
            if win > bet {
                showAlert = true
            }
        })
    }
}

#Preview {
    SlotsGame()
}
