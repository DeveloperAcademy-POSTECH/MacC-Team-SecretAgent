//
//  SirenViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/19.
//

import SnapKit
import UIKit

private enum Constants {
    static let progressBarSize = 300
    static let selectedSeconds = 5 * 1
}

final class SirenViewController: BaseViewController {
    // MARK: - Properties

    @IBOutlet var minutes: UILabel!

    @IBOutlet var seconds: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    @IBOutlet var counterView: UIStackView!

    private let countdownTimer: CountDownTimer = .init(totalSeconds: Constants.selectedSeconds)
    private var countdownTimerDidStart = false
    private let progressBar: ProgressBar = .init(totalSeconds: Constants.selectedSeconds)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setNotification()
    }

    override func render() {
        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }

    override func configUI() {
        super.configUI()
        countdownTimer.setTimer()
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        counterView.isHidden = false
        minutes.text = String(format: "%02d",
                              Constants.selectedSeconds / 60)
        seconds.text = String(format: "%02d",
                              Constants.selectedSeconds % 60)
    }

    // MARK: - Func

    private func setDelegation() {
        countdownTimer.delegate = self
        progressBar.delegate = self
    }

    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(addBackgroundTime(_:)), name: NSNotification.Name("sceneWillEnterForeground"), object: nil)
    }

    @objc func addBackgroundTime(_ notification: Notification) {
        if countdownTimerDidStart == true {
            let time = notification.userInfo?["time"] as? Double ?? 0.0
            countdownTimer.duration -= time
        }
    }

    @IBAction func stopTimer(_ sender: UIButton) {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopButton.isEnabled = false
        stopButton.alpha = 0.8
        startButton.setTitle("시작", for: .normal)
    }

    @IBAction func startTimer(_ sender: UIButton) {
        counterView.isHidden = false
        stopButton.isEnabled = true
        stopButton.alpha = 1.0

        if !countdownTimerDidStart {
            countdownTimer.runTimer()
            progressBar.start()
            countdownTimerDidStart = true
            startButton.setTitle("일시 정지", for: .normal)
        } else {
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startButton.setTitle("재개", for: .normal)
        }
    }
}

// MARK: CountdownTimerDelegate

extension SirenViewController: CountdownTimerDelegate {
    func countdownTime(time: (minutes: String, seconds: String)) {
        minutes.text = time.minutes
        seconds.text = time.seconds
    }

    func countdownTimerDone() {
        counterView.isHidden = true
        stopButton.isEnabled = false
        stopButton.alpha = 0.8
        startButton.setTitle("시작", for: .normal)
        countdownTimerDidStart = false
        progressBar.stop()
    }
}

// MARK: - ProgressBarDelegate

extension SirenViewController: ProgressBarDelegate {
    func progressFinished() {
        let afterTimerViewController = AfterTimerViewController()
        afterTimerViewController.modalTransitionStyle = .crossDissolve
        afterTimerViewController.modalPresentationStyle = .fullScreen
        self.present(afterTimerViewController, animated: true)
    }
}
