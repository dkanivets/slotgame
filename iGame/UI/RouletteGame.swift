//
//  SlotsGame.swift
//  iGame
//
//  Created by Dmitry Kanivets on 16.02.2024.
//

import SwiftUI

struct RouletteGame: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var animation = 1.0
    @State private var coins: Int = 50000
    @State private var bet: Int = 2000
    @State private var win: Int = 0
    @State private var angle: Angle = Angle(degrees: 0)
    private var results = [10000, 1000, 100, 3000, 0, 5000, 8000, 7000, 10000, 9000, 100, 7000, 0, 6000, 4000, 2000]
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(spacing: 0) {
                navigationButtons
                Spacer()
                BottomView(coins: $coins, bet: $bet, win: $win, betStep: 50, action: {
                    angle = Angle(degrees: 0)
                    withAnimation(.linear(duration: 2)) {
                        angle = Angle(degrees: Double.random(in: 0...720))
                        coins -= bet
                        calculateWin()
                    }
                })
            }
            .background(
                Image("ic_roulette_bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .ignoresSafeArea(.all)
            rouletteView
        }
        .navigationBarHidden(true)
    }
    
    private var rouletteView: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                ZStack(alignment: .top) {
                    Image("ic_action_wheel")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(angle)
                        .overlay {
                            Image("ic_center")
                        }
                    Image("ic_fixed_frame")
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Image("ic_arrow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.height / 12, 
                                   height: geometry.size.height / 12)
                            .shadow(color: .black, radius: 10, y: 10)
                            .padding(.top, geometry.size.height / 16)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(16)
        }
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
    
    private func calculateWin() {
        var angle = angle.degrees
        let step = (360 / Double(results.count))
        let halfStep = step / 2
        if angle > 360 {
            angle -= 360
        }
        angle -= halfStep
        let index = Int(floor(angle / step))
        let result = results.reversed()[index]
        win = bet * calculateMultiplier(result: result)
        coins += win
    }
    
    private func calculateMultiplier(result: Int) -> Int {
        return result / 1000
    }
}

#Preview {
    RouletteGame()
}
