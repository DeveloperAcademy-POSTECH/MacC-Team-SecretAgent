//
//  ProgressBar.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/19.
//

import UIKit

private enum Size {
    static let startAngle = Double(-Double.pi / 2)
    static let endAngle = Double(3 * Double.pi / 2)
}

final class ProgressBar: UIView, CAAnimationDelegate {
    // MARK: - Properties

    private var animation = CABasicAnimation()
    private var animationDidStart = false
    private var timerDuration = 0
    private let foregroundProgressLayer: CAShapeLayer = .init()
    private let backgroundProgressLayer: CAShapeLayer = .init()

    private lazy var centerPoint = CGPoint(x: frame.width / 2,
                                           y: frame.height / 2)

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadBackgroundProgressBar()
        loadForegroundProgressBar()
    }

    // MARK: - Func

    private func loadForegroundProgressBar() {
        foregroundProgressLayer.path = UIBezierPath(
            arcCenter: centerPoint,
            radius: frame.width / 2 - 30.0,
            startAngle: Size.startAngle,
            endAngle: Size.endAngle,
            clockwise: true
        ).cgPath
        foregroundProgressLayer.configProgressBar(
            strokeColor: UIColor.blue.cgColor,
            strokeEnd: 0.0
        )
        backgroundProgressLayer.addSublayer(foregroundProgressLayer)
    }

    private func loadBackgroundProgressBar() {
        backgroundProgressLayer.path = UIBezierPath(
            arcCenter: centerPoint,
            radius: frame.width / 2 - 30.0,
            startAngle: Size.startAngle,
            endAngle: Size.endAngle,
            clockwise: true
        ).cgPath
        backgroundProgressLayer.configProgressBar(
            strokeColor: UIColor.gray.cgColor,
            strokeEnd: 1.0
        )
        layer.addSublayer(backgroundProgressLayer)
    }

    // 프로그래스바 설정
    func setProgressBar(minutes: Int, seconds: Int) {
        let minutesToSeconds = minutes * 60
        let totalSeconds = seconds + minutesToSeconds
        timerDuration = totalSeconds
    }

    // 애니메이션 시작
    private func startAnimation() {
        resetAnimation()
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = CFTimeInterval(timerDuration)
        animation.delegate = self
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        foregroundProgressLayer.add(animation, forKey: "strokeEnd")
        animationDidStart = true
    }

    // 애니메이션 초기화
    private func resetAnimation() {
        foregroundProgressLayer.configForAnimation()
        animationDidStart = false
    }

    // 애니메이션 멈춤
    private func stopAnimation() {
        foregroundProgressLayer.configForAnimation()
        foregroundProgressLayer.removeAllAnimations()
        animationDidStart = false
    }

    // 애니메이션 일시정지
    private func pauseAnimation() {
        let pausedTime = foregroundProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foregroundProgressLayer.speed = 0.0
        foregroundProgressLayer.timeOffset = pausedTime
    }

    // 애니메이션 재개
    private func resumeAnimation() {
        let pausedTime = foregroundProgressLayer.timeOffset
        foregroundProgressLayer.speed = 1.0
        foregroundProgressLayer.timeOffset = 0.0
        foregroundProgressLayer.beginTime = 0.0
        let timeSincePause = foregroundProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        foregroundProgressLayer.beginTime = timeSincePause
    }

    // 시작 버튼 클릭시
    func start() {
        if !animationDidStart {
            startAnimation()
        } else {
            resumeAnimation()
        }
    }

    // 일시정지 버튼 클릭시
    func pause() {
        pauseAnimation()
    }

    // 멈춤 버튼 클릭시
    func stop() {
        stopAnimation()
    }
}

// MARK: - CAShapeLayer

extension CAShapeLayer {
    func configProgressBar(strokeColor: CGColor, strokeEnd: Double) {
        self.strokeColor = strokeColor
        backgroundColor = UIColor.clear.cgColor
        fillColor = UIColor.clear.cgColor
        lineWidth = 24.0
        strokeStart = 0.0
        self.strokeEnd = strokeEnd
    }

    func configForAnimation() {
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        strokeEnd = 0.0
    }
}
