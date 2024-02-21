//
//  SelectGameView.swift
//  iGame
//
//  Created by Dmitry Kanivets on 15.02.2024.
//

import SwiftUI

struct SelectGameView: View {
    private var font = Font.custom("Suranna", size: 28)
    private var opacity: CGFloat = 0.69
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topTrailing) {
                gamesView
                settingsView
            }
            .background(
                Image("ic_bg")
                    .resizable()
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
        }
        .navigationViewStyle(.stack)
        .navigationBarHidden(true)
    }
    
    private var settingsView: some View {
        NavigationLink(destination: SettingsView()) {
            Image("ic_settings")
                .padding(32)
        }
    }
    
    private var gamesView: some View {
        HStack(alignment: .center, spacing: 64) {
            openGameView(title: String(localized: "selectGame.slots.title"),
                         image: "ic_slots",
                         destination: SlotsGame())
            openGameView(title: String(localized: "selectGame.roulette.title"),
                         image: "ic_roulette",
                         destination: RouletteGame())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func openGameView(title: String, image: String, destination: some View) -> some View {
        VStack(spacing: 16) {
            VStack (spacing: 0){
                Image(image)
                    .background(Color.green)
                Text(title)
                    .font(font)
                    .foregroundColor(.white)
            }
            .background(
                Color.black
                    .opacity(opacity)
            )
            .cornerRadius(12)
            NavigationLink(destination: destination) {
                Image("ic_play")
            }
        }
    }
}

#Preview {
    SelectGameView()
}
