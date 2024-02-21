//
//  AudioManager.swift
//  iGame
//
//  Created by Dmitry Kanivets on 21.02.2024.
//

import Foundation
import AVFoundation
import Combine

final class AudioManager: ObservableObject {
    @Published var isPlaying: Bool = true
    var audioPlayer: AVAudioPlayer!
    var cancellables = Set<AnyCancellable>()
    func play() {
        if audioPlayer == nil {
            let sound = "theme"
            let type = "mp3"
            
            if let path = Bundle.main.path(forResource: sound, ofType: type), isPlaying {
                do {
                    _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .mixWithOthers)
                    audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                    audioPlayer?.play()
                    audioPlayer.numberOfLoops = -1
                } catch {
                    print("Error playing sound")
                }
            }
        } else {
            audioPlayer.play()
        }
    }
    func stop() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
    func subscribe() {
        $isPlaying.sink { [weak self] isPlaying in
            if isPlaying {
                self?.play()
            } else {
                self?.stop()
            }
        }
        .store(in: &cancellables)
    }
}
