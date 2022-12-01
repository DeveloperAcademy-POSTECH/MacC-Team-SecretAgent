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
    func countdownThirtySecond()
    
}

final class CountDownTimer {
    // MARK: - Properties

    weak var delegate: CountdownTimerDelegate?

    private let totalSeconds: Int
    var duration: Double = 0.0

    private var timer: Timer = .init()

    // MARK: - Init

    init(totalSeconds: Int) {
        self.totalSeconds = totalSeconds
        duration = Double(totalSeconds)
    }

    // MARK: - Func

    // 타이머 설정
    func setTimer() {
        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }

    // 타이머 실행
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    // 타이머 실시간 업데이트
    @objc private func updateTimer() {
        if duration <= 0.0 {
            timerDone()
        } else {
            duration -= 0.01
            delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))

            if ceil(duration) == 30 {
                delegate?.countdownThirtySecond()
            }
        }
    }

    // 타이머 종료
    private func timerDone() {
        timer.invalidate()
        duration = Double(totalSeconds)
        delegate?.countdownTimerDone()
    }

    // 타이머 일시정지 버튼 클릭시
    func pause() {
        timer.invalidate()
    }

    // 타이머 멈춤 버튼 클릭시
    func stop() {
        timer.invalidate()
        duration = Double(totalSeconds)
        delegate?.countdownTime(time: timeString(time: TimeInterval(ceil(duration))))
    }

    // TimeIntervalToString
    private func timeString(time: TimeInterval) -> (minutes: String, seconds: String) {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return (minutes: String(format: "%02d", minutes), seconds: String(format: "%02d", seconds))
    }
}
