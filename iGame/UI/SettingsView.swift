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
    private var privacyURL = "https://www.lipsum.com/feed/html"
    private var termsURL = "https://www.lipsum.com/feed/html"
    var body: some View {
        ZStack(alignment: .topLeading) {
            settingsButtons
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("ic_back")
            })
            .padding(32)
        }
        .background(
            Image("ic_bg")
                .resizable()
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear(perform: {
            if audioManager != nil {
                soundOn = audioManager.isPlaying
            }
        })
    }
    private var settingsButtons: some View {
        VStack(alignment: .center, spacing: 8) {
            Button(action: {
                soundOn.toggle()
                audioManager.isPlaying.toggle()
            }, label: {
                if soundOn {
                    Image("ic_sound_on")
                } else {
                    Image("ic_sound_off")
                }
            })
            Link(destination: URL(string: privacyURL)!,
                 label: {
                Image("ic_privacy")
            })
            Link(destination: URL(string: termsURL)!,
                 label: {
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
