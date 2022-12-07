//
//  SoundManager.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/30.
//

import AVFoundation
import UIKit

class SoundManager {
    // MARK: - Properties

    static let shared = SoundManager()
    private var player: AVAudioPlayer?

    // MARK: - Init

    private init() {}

    // MARK: - Func

    func setupSound(soundOption: SoundLiteral, repeated: Bool = true) {
        guard let url = Bundle.main.url(forResource: soundOption(), withExtension: MusicExtension.mp3()) else { return }

        do {
            // MARK: - 나중에 무음모드에도 소리를 재생하고 싶으면 아래 코드를 주석해제하세요

//            try AVAudioSession.sharedInstance().setCategory(.playback)
//            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            guard let sound = player else { return }
            if repeated {
                sound.numberOfLoops = -1
            }
            sound.prepareToPlay()
        } catch {
            print("오디오 파일을 찾을 수 없습니다.")
        }
    }

    func playSound() {
        if let player {
            player.play()
        }
    }

    func stopSound() {
        if let player {
            player.stop()
        }
    }

    func pauseSound() {
        if let player {
            player.pause()
        }
    }
}
