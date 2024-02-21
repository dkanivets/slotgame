//
//  iGameApp.swift
//  iGame
//
//  Created by Dmitry Kanivets on 15.02.2024.
//

import SwiftUI

@main
struct iGameApp: App {
    @StateObject private var audioManager = AudioManager()

    var body: some Scene {
        WindowGroup {
            SelectGameView()
                .onAppear(perform: {
                    audioManager.play()
                    audioManager.subscribe()
                    for family in UIFont.familyNames {
                        print("\(family)")

                        for name in UIFont.fontNames(forFamilyName: family) {
                            print("   \(name)")
                        }
                    }
                })
        }
        .environmentObject(audioManager)
    }
}
