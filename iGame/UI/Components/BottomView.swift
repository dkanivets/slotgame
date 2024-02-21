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
    var body: some View {
        bottomView
    }
    private var bottomView: some View {
        HStack(alignment: .center, spacing: 16) {
            Spacer()
            coinsView
            betView
            winView
            Button(action: {
                bet = coins
            }, label: {
                Image("ic_max_bet")
            })
            Button(action: {
                action()
            }, label: {
                Image("ic_spin")
            })
            .disabled(
                coins < bet
            )
            .opacity(coins < bet ? 0.8 : 1)
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
        Group {
            Button(action: {
                if bet > betStep {
                    bet -= betStep
                }
            }, label: {
                Image("ic_minus")
            })
            VStack {
                Text("bottomView.totalBet.title")
                    .foregroundColor(.white.opacity(0.3))
                    .font(fontInter)
                Text("\(bet)")
                    .foregroundColor(.white)
                    .font(fontInter)
            }
            .frame(minWidth: 130)
            .frame(height: 41)
            .background(
                Image("ic_text_bg")
                    .resizable()
            )
            Button(action: {
                if bet + betStep <= coins {
                    bet += betStep
                }
            }, label: {
                Image("ic_plus")
            })
        }
    }
    
    private var winView: some View {
        VStack {
            Text("bottomView.win.title")
                .foregroundColor(.white.opacity(0.3))
                .font(fontInter)
            Text("\(win)")
                .foregroundColor(.white)
                .font(fontInter)
        }
        .frame(minWidth: 194)
        .frame(height: 41)
        .background(
            Image("ic_text_bg")
                .resizable()
        )
    }
}

#Preview {
    BottomView(coins: .constant(1000), 
               bet: .constant(50),
               win: .constant(0), 
               betStep: 10,
               action: {})
}
