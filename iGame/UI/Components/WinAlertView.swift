//
//  WinAlertView.swift
//  iGame
//
//  Created by Dmitry Kanivets on 21.02.2024.
//

import SwiftUI

struct WinAlertView: View {
    private let blueColor = Color("blueColor")
    private let fontOpenSansHebrew22 = Font.custom("OpenSansHebrew-Bold", size: 22)
    private let fontOpenSansHebrew26 = Font.custom("OpenSansHebrew-Bold", size: 26)
    @Binding var showModal: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Text("You Win!")
                .foregroundColor(.white)
                .font(fontOpenSansHebrew22)
            Text("Congratulations!")
                .font(fontOpenSansHebrew26)
                .foregroundColor(.white)
                .padding(.vertical, 12)
            Image("ic_coins")
            Button(action: {
                showModal = false
            }, label: {
                Image("ic_play_more")
            })
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 48)
        .background(blueColor.opacity(0.85))
        .clipped()
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 2)
        )
        .presentationBackground(.clear)
    }
}

#Preview {
    WinAlertView(showModal: .constant(true))
}
