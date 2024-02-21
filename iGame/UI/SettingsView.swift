//
//  SettingsView.swift
//  iGame
//
//  Created by Dmitry Kanivets on 16.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var audioManager: AudioManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var soundOn: Bool = true
    private let privacyURL = "https://www.lipsum.com/feed/html"
    private let termsURL = "https://www.lipsum.com/feed/html"
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            settingsButtons
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("ic_back")
            }
            .padding(32)
        }
        .background(
            Image("ic_bg")
                .resizable()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear {
            soundOn = audioManager.isPlaying
        }
    }
    
    private var settingsButtons: some View {
        VStack(alignment: .center, spacing: 8) {
            Button(action: {
                soundOn.toggle()
                audioManager.isPlaying.toggle()
            }) {
                Image(soundOn ? "ic_sound_on" : "ic_sound_off")
            }
            Link(destination: URL(string: privacyURL)!, label: {
                Image("ic_privacy")
            })
            Link(destination: URL(string: termsURL)!, label: {
                Image("ic_terms")
            })
            Button(action: {}, label: {
                Image("ic_share")
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    SettingsView()
}
