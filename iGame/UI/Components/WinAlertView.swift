//
//  WinAlertView.swift
//  iGame
//
//  Created by Dmitry Kanivets on 21.02.2024.
//

import SwiftUI

struct WinAlertView: View {
    @Binding var showModal: Bool
    
    private let blueColor = Color("blueColor")
    private let fontOpenSansHebrew22 = Font.custom("OpenSansHebrew-Bold", size: 22)
    private let fontOpenSansHebrew26 = Font.custom("OpenSansHebrew-Bold", size: 26)
    private let textOpacity: CGFloat = 0.85
    
    var body: some View {
        VStack(spacing: 12) {
            winText
            congratsText
            Image("ic_coins")
            playMoreButton
        }
        .padding(24)
        .background(blueColor.opacity(textOpacity))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 2)
        )
        .presentationBackground(Color.clear)
    }
    
    private var winText: some View {
        Text("You Win!")
            .foregroundColor(.white)
            .font(fontOpenSansHebrew22)
    }
    
    private var congratsText: some View {
        Text("Congratulations!")
            .foregroundColor(.white)
            .font(fontOpenSansHebrew26)
            .padding(.vertical, 12)
    }
    
    private var playMoreButton: some View {
        Button(action: {
            showModal = false
        }) {
            Image("ic_play_more")
        }
    }
}

#Preview {
    WinAlertView(showModal: .constant(true))
}
