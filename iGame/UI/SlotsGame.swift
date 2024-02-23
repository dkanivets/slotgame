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
                BottomView(coins: $coins, bet: $bet, win: $win, betStep: 10, action: spin)
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
        .onAppear {
            slots = (1...5).map { _ in baseSet.shuffled() }
        }
        .ignoresSafeArea(.all)
        .sheet(isPresented: $showAlert) {
            WinAlertView(showModal: $showAlert)
        }
    }
    
    private var slotMachineView: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                slotRows(geometry: geometry)
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

    private func slotRows(geometry: GeometryProxy) -> some View {
        HStack(alignment: .center, spacing: 16) {
            ForEach(slots, id: \.self) { slot in
                ScrollViewReader { scrollProxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        slotColumns(slot: slot, geometry: geometry)
                    }
                    .frame(height: (geometry.size.height / 5 + 16) * 3)
                }
            }
        }
    }

    private func slotColumns(slot: [String], geometry: GeometryProxy) -> some View {
        VStack(alignment: .center, spacing: 16) {
            ForEach(slot, id: \.self) { item in
                Image(item)
                    .resizable()
                    .frame(width: geometry.size.height / 5, height: geometry.size.height / 5)
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 0) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("ic_back")
            }
            Spacer()
            NavigationLink(destination: SettingsView()) {
                Image("ic_settings")
            }
        }
        .padding(32)
    }
    
    private func calculateWin(with result: Int) {
        let multiplier: Int
        
        switch result {
        case 1:
            multiplier = 10
        case 2:
            multiplier = 5
        case 3:
            multiplier = 2
        case 4:
            multiplier = 1
        default:
            multiplier = 0
        }
        
        let resultToCoins = bet * multiplier
        win = resultToCoins
        coins += resultToCoins
    }
    
    private func spin() {
        withAnimation(.interpolatingSpring) {
            coins -= bet
            slots.indices.forEach { index in
                slots[index] = slots[index].shift(withDistance: Int.random(in: 0...6))
            }
            let result = Set(slots.map { $0[1] }).count
            calculateWin(with: result)
        }
        showAlert = win > bet
    }
}

#Preview {
    SlotsGame()
}
