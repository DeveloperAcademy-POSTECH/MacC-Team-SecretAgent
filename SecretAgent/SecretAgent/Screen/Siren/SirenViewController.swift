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
    static let timeHStackViewHorizontalOffset = UIScreen.main.bounds.width / 2.48
    static let buttonHStackViewBottomOffset = UIScreen.main.bounds.height / 5.20
    static let defaultOffset = 20
}

final class SirenViewController: BaseViewController {
    // MARK: - Properties

    private let sirenButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(ImageLiteral.siren, for: .normal)
        button.adjustsImageWhenHighlighted = false
        return button
    }()

    private let sirenBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let speechImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageLiteral.speech
        return imageView
    }()

    private let timeHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()

    private let timeVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()

    private let timeLabel = {
        let label = UILabel()
        label.text = "남은 시간"
        label.textColor = .yoOrange
        label.font = .regularCaption1
        label.textAlignment = .center
        return label
    }()

    private let minutesLabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .yoOrange
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let colonLabel = {
        let label = UILabel()
        label.text = ":"
        label.textColor = .yoOrange
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let secondsLabel = {
        let label = UILabel()
        label.text = "00"
        label.textColor = .yoOrange
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let startButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "시작", color: .yoGreen)
        button.setButtonTextColor(color: .white)
        button.makeButtonSmall()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let stopButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "취소", color: .white)
        button.setButtonTextColor(color: .orange)
        button.setButtonBorder(color: UIColor.yoOrange.cgColor)
        button.makeButtonSmall()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let buttonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 28
        return stackView
    }()

    private let countdownTimer: CountDownTimer = .init(totalSeconds: Constants.selectedSeconds)
    private var countdownTimerDidStart = false
    private let progressBar: ProgressBar = .init(totalSeconds: Constants.selectedSeconds)

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setNotification()
        addTargets()
    }

    override func render() {
        view.addSubview(speechImageView)
        speechImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.defaultOffset)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.defaultOffset)
        }

        view.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        [minutesLabel, colonLabel, secondsLabel].forEach { label in
            timeHStackView.addArrangedSubview(label)
        }

        timeVStackView.addArrangedSubview(timeLabel)
        timeVStackView.addArrangedSubview(timeHStackView)
        view.addSubview(timeVStackView)
        timeVStackView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(progressBar)
        }

        view.addSubview(buttonHStackView)
        buttonHStackView.addArrangedSubview(stopButton)
        buttonHStackView.addArrangedSubview(startButton)
        buttonHStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(31)
            make.bottom.equalToSuperview().inset(Constants.buttonHStackViewBottomOffset)
        }

        sirenBackgroundView.addSubview(sirenButton)
        sirenButton.snp.makeConstraints { make in
            make.size.equalTo(239)
            make.center.equalToSuperview()
        }

        view.addSubview(sirenBackgroundView)
        sirenBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func configUI() {
        super.configUI()
        startButton.setButton(text: "시작", color: .yoOrange)
        startButton.backgroundColor = .yoOrange
        startButton.setButtonTextColor(color: .white)
        startButton.makeButtonSmall()

        stopButton.setButton(text: "취소", color: .white)
        stopButton.setButtonTextColor(color: .yoOrange)
        stopButton.setButtonBorder(color: UIColor.yoOrange.cgColor)
        stopButton.makeButtonSmall()

        countdownTimer.setTimer()
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
//        counterView.isHidden = false
        minutesLabel.text = String(format: "%02d",
                                   Constants.selectedSeconds / 60)
        secondsLabel.text = String(format: "%02d",
                                   Constants.selectedSeconds % 60)
    }

    // MARK: - Func

    private func setDelegation() {
        countdownTimer.delegate = self
        progressBar.delegate = self
    }

    private func addTargets() {
        startButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopTimer), for: .touchUpInside)
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

    @objc private func stopTimer() {
        countdownTimer.stop()
        progressBar.stop()
        countdownTimerDidStart = false
        stopButton.isEnabled = false
        stopButton.alpha = 0.8
        startButton.setTitle("시작", for: .normal)
    }

    @objc private func startTimer() {
//        counterView.isHidden = false
        stopButton.isEnabled = true
        stopButton.alpha = 1.0

        if !countdownTimerDidStart {
            countdownTimer.runTimer()
            progressBar.start()
            countdownTimerDidStart = true
            startButton.setTitle("일시 정지", for: .normal)
            startButton.backgroundColor = .yoOrange
        } else {
            countdownTimer.pause()
            progressBar.pause()
            countdownTimerDidStart = false
            startButton.setTitle("재개", for: .normal)
            startButton.backgroundColor = .yoGreen
        }
    }
}

// MARK: CountdownTimerDelegate

extension SirenViewController: CountdownTimerDelegate {
    func countdownTime(time: (minutes: String, seconds: String)) {
        minutesLabel.text = time.minutes
        secondsLabel.text = time.seconds
    }

    func countdownTimerDone() {
//        counterView.isHidden = true
        stopButton.isEnabled = false
        stopButton.alpha = 0.8
        startButton.setTitle("시작", for: .normal)
        countdownTimerDidStart = false
        progressBar.stop()
    }
}

// MARK: ProgressBarDelegate

extension SirenViewController: ProgressBarDelegate {
    func progressFinished() {
        let afterTimerViewController = AfterTimerViewController()
        afterTimerViewController.modalTransitionStyle = .crossDissolve
        afterTimerViewController.modalPresentationStyle = .fullScreen
        present(afterTimerViewController, animated: true)
    }
}
