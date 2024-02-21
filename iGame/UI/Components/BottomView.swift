//
//  BottomView.swift
//  iGame
//
//  Created by Dmitry Kanivets on 20.02.2024.
//

import SwiftUI

struct BottomView: View {
    @Binding var coins: Int
    @Binding var bet: Int
    @Binding var win: Int
    var betStep: Int
    var action: () -> Void
    
    private let fontInter = Font.custom("Inter-Bold", size: 11)
    private let fontKoh = Font.custom("KohSantepheap-Bold", size: 20)
    private let opacity: CGFloat = 0.8
    private let textOpacity: CGFloat = 0.3
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Spacer()
            coinsView
            betView
            winView
            maxBetButton
            spinButton
                .disabled(coins < bet)
                .opacity(coins < bet ? opacity : 1)
            Spacer()
        }
        .background(
            Image("ic_nav_bg")
                .resizable()
                .scaledToFill()
                .frame(height: 66)
                .frame(maxWidth: .infinity)
                .clipped()
        )
        .frame(height: 66)
        .frame(maxWidth: .infinity)
    }
    
    private var coinsView: some View {
        HStack {
            Image("ic_coin")
            Text("\(coins)")
                .foregroundColor(.white)
                .font(fontKoh)
        }
        .padding(8)
        .background(
            Image("ic_text_bg")
                .resizable()
        )
    }
    
    private var betView: some View {
        HStack {
            minusButton
            VStack {
                Text("bottomView.totalBet.title")
                    .foregroundColor(.white.opacity(textOpacity))
                    .font(fontInter)
                Text("\(bet)")
                    .foregroundColor(.white)
                    .font(fontInter)
            }
            .frame(minWidth: 130, minHeight: 41)
            .background(
                Image("ic_text_bg")
                    .resizable()
            )
            plusButton
        }
    }
    
    private var winView: some View {
        VStack {
            Text("bottomView.win.title")
                .foregroundColor(.white.opacity(textOpacity))
                .font(fontInter)
            Text("\(win)")
                .foregroundColor(.white)
                .font(fontInter)
        }
        .frame(minWidth: 194, minHeight: 41)
        .background(
            Image("ic_text_bg")
                .resizable()
        )
    }
    
    private var maxBetButton: some View {
        Button(action: {
            bet = coins
        }) {
            Image("ic_max_bet")
        }
    }
    
    private var spinButton: some View {
        Button(action: {
            action()
        }) {
            Image("ic_spin")
        }
    }
    
    private var minusButton: some View {
        Button(action: {
            if bet > betStep {
                bet -= betStep
            }
        }) {
            Image("ic_minus")
        }
    }
    
    private var plusButton: some View {
        Button(action: {
            if bet + betStep <= coins {
                bet += betStep
            }
        }) {
            Image("ic_plus")
        }
    }
}


#Preview {
    BottomView(coins: .constant(1000), 
               bet: .constant(50),
               win: .constant(0), 
               betStep: 10,
               action: {})
}
