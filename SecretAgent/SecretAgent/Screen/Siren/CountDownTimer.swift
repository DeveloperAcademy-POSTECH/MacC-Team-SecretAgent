//
//  CountDownTimer.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/19.
//

import UIKit

protocol CountdownTimerDelegate: AnyObject {
    func countdownTimerDone()
    func countdownTime(time: (minutes: String, seconds: String))
}

final class CountDownTimer {
    // MARK: - Properties

    weak var delegate: CountdownTimerDelegate?

    private var seconds = 0.0
    var duration = 0.0

    private var timer: Timer = .init()

    // MARK: - Func

    // 타이머 설정
    func setTimer(minutes: Int, seconds: Int) {
        let minutesToSeconds = minutes * 60
        let secondsToSeconds = seconds

        let seconds = secondsToSeconds + minutesToSeconds
        self.seconds = Double(seconds)
        duration = Double(seconds)

        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }

    // 타이머 실행
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true) // 왜 0.01초로 했을까?
    }

    // 타이머 실시간 업데이트
    @objc private func updateTimer() {
        if duration <= 0.0 {
            timerDone()
        } else {
            duration -= 0.01
            delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
        }
    }

    // 타이머 종료
    private func timerDone() {
        timer.invalidate()
        duration = seconds
        delegate?.countdownTimerDone()
    }

    // 타이머 일시정지 버튼 클릭시
    @objc func pause() {
        timer.invalidate()
    }

    // 타이머 멈춤 버튼 클릭시
    func stop() {
        timer.invalidate()
        duration = seconds
        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }

    // TimeIntervalToString
    private func timeString(time: TimeInterval) -> (minutes: String, seconds: String) {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return (minutes: String(format: "%02d", minutes), seconds: String(format: "%02d", seconds))
    }
}
