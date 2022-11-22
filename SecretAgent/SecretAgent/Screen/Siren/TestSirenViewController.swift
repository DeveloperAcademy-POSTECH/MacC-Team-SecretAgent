//
//  TestSirenViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/21.
//

import AVFoundation
import UIKit

import SnapKit

class TestSirenViewController: BaseViewController, AVAudioPlayerDelegate {
    // MARK: - Properties

    private var sirenPlayer: AVAudioPlayer?

    private lazy var sirenButton: UIButton = {
        let button = UIButton()
        button.setTitle("사이렌 울리기", for: .normal)
        button.addTarget(self, action: #selector(playSiren), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func render() {
        view.addSubview(sirenButton)
        sirenButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc func playSiren() {
        guard let path = Bundle.main.path(forResource: SoundLiteral.siren.fileName(), ofType: nil) else { return }
        let url = URL(fileURLWithPath: path)

        do {
            sirenPlayer = try AVAudioPlayer(contentsOf: url)
            sirenPlayer?.delegate = self
            sirenPlayer?.play()
        } catch {
            print(error)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
        // TODO: 타이머 화면 시작
    }
}
