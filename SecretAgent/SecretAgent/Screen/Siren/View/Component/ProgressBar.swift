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
    static let width = UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? 300 : 230
    static let height = UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? 300 : 230 
}

final class ProgressBar: UIView {
    // MARK: - Properties

    private var animation = CABasicAnimation()
    private var animationDidStart = false
    private var timerDuration = 0
    let foregroundProgressLayer: CAShapeLayer = .init()
    private let backgroundProgressLayer: CAShapeLayer = .init()

    private var centerPoint: CGPoint = .init(x: 0, y: 0)

    var isProgressDone = false

    // MARK: - Init

    convenience init(totalSeconds: Int) {
        self.init()
        frame.size = .init(width: ProgressBarSize.width,
                           height: ProgressBarSize.height)
        timerDuration = totalSeconds
        loadBackgroundProgressBar()
        loadForegroundProgressBar()
    }

    // MARK: - Func

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

    // ??????????????? ??????
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

    // ??????????????? ?????????
    private func resetAnimation() {
        foregroundProgressLayer.configForAnimation()
        animationDidStart = false
    }

    // ??????????????? ??????
    private func stopAnimation() {
        foregroundProgressLayer.configForAnimation()
        foregroundProgressLayer.removeAllAnimations()
        animationDidStart = false
    }

    // ??????????????? ????????????
    private func pauseAnimation() {
        let pausedTime = foregroundProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foregroundProgressLayer.speed = 0.0
        foregroundProgressLayer.timeOffset = pausedTime
    }

    // ??????????????? ??????
    private func resumeAnimation() {
        let pausedTime = foregroundProgressLayer.timeOffset
        foregroundProgressLayer.speed = 1.0
        foregroundProgressLayer.timeOffset = 0.0
        foregroundProgressLayer.beginTime = 0.0
        let timeSincePause = foregroundProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        foregroundProgressLayer.beginTime = timeSincePause
    }

    // ?????? ?????? ?????????
    func start() {
        if !animationDidStart {
            startAnimation()
        } else {
            resumeAnimation()
        }
    }

    // ???????????? ?????? ?????????
    func pause() {
        pauseAnimation()
    }

    // ?????? ?????? ?????????
    func stop() {
        stopAnimation()
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
