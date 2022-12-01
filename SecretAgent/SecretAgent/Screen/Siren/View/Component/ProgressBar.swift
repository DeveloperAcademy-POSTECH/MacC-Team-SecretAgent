//
//  ProgressBar.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/19.
//

import UIKit

private enum ProgressBarSize {
    static let startAngle = Double(-Double.pi / 2)
    static let endAngle = Double(3 * Double.pi / 2)
    static let width = 300
    static let height = 300
}

protocol ProgressBarDelegate: AnyObject {
    func progressFinished()
}

final class ProgressBar: UIView {
    // MARK: - Properties

    private var animation = CABasicAnimation()
    private var animationDidStart = false
    private var timerDuration = 0
    private let foregroundProgressLayer: CAShapeLayer = .init()
    private let backgroundProgressLayer: CAShapeLayer = .init()

    private var centerPoint: CGPoint = .init(x: 0, y: 0)

    var delegate: ProgressBarDelegate?

    var isProgressDone = false

    // MARK: - Init

    convenience init(totalSeconds: Int) {
        self.init()
        frame.size = .init(width: ProgressBarSize.width,
                           height: ProgressBarSize.height)
        timerDuration = totalSeconds
        loadBackgroundProgressBar()
        loadForegroundProgressBar()
        setDelegation()
    }

    // MARK: - Func

    private func setDelegation() {
        animation.delegate = self
    }

    private func loadBackgroundProgressBar() {
        backgroundProgressLayer.path = UIBezierPath(
            arcCenter: centerPoint,
            radius: frame.width / 2 - 30.0,
            startAngle: ProgressBarSize.startAngle,
            endAngle: ProgressBarSize.endAngle,
            clockwise: true
        ).cgPath
        backgroundProgressLayer.configProgressBar(
            strokeColor: UIColor.yoOrange.cgColor,
            strokeEnd: 1.0
        )
        layer.addSublayer(backgroundProgressLayer)
    }

    private func loadForegroundProgressBar() {
        foregroundProgressLayer.path = UIBezierPath(
            arcCenter: centerPoint,
            radius: frame.width / 2 - 30.0,
            startAngle: ProgressBarSize.startAngle,
            endAngle: ProgressBarSize.endAngle,
            clockwise: true
        ).cgPath
        foregroundProgressLayer.configProgressBar(
            strokeColor: UIColor.yoGray3.cgColor,
            strokeEnd: 0.0
        )
        backgroundProgressLayer.addSublayer(foregroundProgressLayer)
    }

    // 애니메이션 시작
    private func startAnimation() {
        resetAnimation()
        animation.keyPath = "strokeEnd"
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = CFTimeInterval(timerDuration)
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

// MARK: CAAnimationDelegate

extension ProgressBar: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            delegate?.progressFinished()
        }
    }
}

// MARK: - CAShapeLayer

private extension CAShapeLayer {
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
