//
//  TestSirenViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/21.
//

import AVFoundation
import UIKit

import SnapKit

class TestSirenViewController: BaseViewController {
    // MARK: - Properties

    private var sirenPlayer: AVAudioPlayer!

    private lazy var sirenButton: UIButton = {
        let button = UIButton()
        button.setTitle("사이렌 울리기", for: .normal)
        button.addTarget(self, action: #selector(playSiren), for: .touchUpInside)
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSiren()
    }

    override func render() {
        view.addSubview(sirenButton)
        sirenButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - Func

    func setupSiren() {
        guard let path = Bundle.main.path(forResource: SoundLiteral.siren(), ofType: MusicExtension.mp3()) else { return }
        let url = URL(fileURLWithPath: path)

        do {
            sirenPlayer = try AVAudioPlayer(contentsOf: url)
            sirenPlayer?.prepareToPlay()
            sirenPlayer?.delegate = self
        } catch {
            print(error)
        }
    }

    @objc func playSiren() {
        sirenPlayer?.play()
    }
}

// MARK: AVAudioPlayerDelegate

extension TestSirenViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
        // TODO: 타이머 화면 시작
    }
}
