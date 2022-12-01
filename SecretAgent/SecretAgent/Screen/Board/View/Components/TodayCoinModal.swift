//
//  TodayCoinModal.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/30.
//

import UIKit

private final class Coin: UIImageView {
    init(frame: CGRect = .zero, isInactive: Bool = false) {
        super.init(frame: frame)
        setCoin(isInactive: isInactive)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setCoin(isInactive: Bool) {
        if isInactive {
            image = ImageLiteral.inactiveCoin
        } else {
            image = ImageLiteral.coin
        }
    }
}

private enum Literal {
    // TODO: - 리터럴에서 변경되어야함

    static let prompt = "오늘 보상 코인 획득까지"
    static let remainTime = " O시간 남음"
    static let description = "사이렌 발동 후 조용하 하기에 실패할 때마다\n보상으로 받을 수 있는 콘의 수가 줄어듭니다."
}

final class TodayCoinModal: UIView {
    // MARK: - Properties

    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        return stackView
    }()

    private let prompt: UILabel = {
        let label = UILabel()

        label.text = Literal.prompt
        label.textColor = .yoBlack
        label.font = .oneMobile(size: 18)
        label.textAlignment = .center
        return label
    }()

    private let remainTime: UILabel = {
        let label = UILabel()

        label.text = Literal.remainTime
        label.textColor = .yoOrange
        label.font = .oneMobile(size: 18)
        label.textAlignment = .center
        return label
    }()

    private let labelStack: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()

        label.text = Literal.description
        label.textColor = .yoGray5
        label.alpha = 0.8
        label.font = .boldCaption1
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - LifeStyle

    init(frame: CGRect = .zero, of number: Int) {
        super.init(frame: frame)
        setCoins(number)
        render()
        configUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(303)
            make.centerX.equalToSuperview()
        }

        labelStack.addArrangedSubview(prompt)
        labelStack.addArrangedSubview(remainTime)

        addSubview(labelStack)
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(36.29)
            make.centerX.equalToSuperview()
        }

        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(prompt.snp.bottom).offset(22.5)
            make.centerX.equalToSuperview()
        }
    }

    private func configUI() {
        backgroundColor = .white
    }

    // MARK: - Func

    private func setCoins(_ number: Int) {
        for _ in 0 ..< number {
            let coin = Coin()
            hStack.addArrangedSubview(coin)
            coin.snp.makeConstraints { make in
                make.height.equalTo(50.21)
                make.width.equalTo(47)
            }
        }
        for _ in 0 ..< 5 - number {
            let coin = Coin(isInactive: true)
            hStack.addArrangedSubview(coin)
            coin.snp.makeConstraints { make in
                make.height.equalTo(50.21)
                make.width.equalTo(47)
            }
        }
    }

    func updateCoins(to number: Int) {
        willRemoveSubview(hStack)
        hStack.subviews.forEach { subView in
            hStack.removeArrangedSubview(subView)
        }
        setCoins(number)
        insertSubview(hStack, at: 0)
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(303)
            make.centerX.equalToSuperview()
        }
    }
}
