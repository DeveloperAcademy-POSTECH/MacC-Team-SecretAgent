//
//  TodayBadge.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/28.
//

import UIKit

private enum Literal: String {
    case todayBadges = "획득예정"

    func callAsFunction() -> String {
        return rawValue
    }
}

private enum Size {
    static let width = 24.0
    static let height = 24.0
}

final class TodayBadgeView: UIStackView {
    // MARK: - Properties

    // 좌상단
    private let coinImageView: UIImageView = {
        let image = ImageLiteral.smallCoin
        let imageView = UIImageView(image: image)

        return imageView
    }()

    // 우상단
    private let numberLabel: UILabel = {
        let label = UILabel()

        label.font = .oneMobile(size: 18)
        label.textColor = .yoGray6

        return label
    }()

    // 상단
    private let coinAndNumber: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        return stackView
    }()

    // 하단
    private let textLabel: UILabel = {
        let label = UILabel()

        label.text = Literal.todayBadges()
        label.font = .oneMobile(size: 11)
        label.textColor = .yoGray5
        label.textAlignment = .center

        return label
    }()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        fetchCoinNumber()
        configUI()
        render()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func fetchCoinNumber() {
        guard let (numberOfCoins, _) = try? BadgeManager.shared.coinsLeftForToday() else { return }
        numberLabel.text = "\(numberOfCoins)"
    }

    private func configUI() {
        configChildViews()
        axis = .vertical
        distribution = .equalSpacing
    }

    private func render() {
        coinImageView.snp.makeConstraints { make in
            make.width.equalTo(Size.width)
            make.height.equalTo(Size.height)
        }
    }

    // MARK: - Func

    private func configChildViews() {
        coinAndNumber.addArrangedSubview(coinImageView)
        coinAndNumber.addArrangedSubview(numberLabel)

        addArrangedSubview(coinAndNumber)
        addArrangedSubview(textLabel)
    }

    func updateNumberOfCoins(to number: Int) {
        fetchCoinNumber(number)
    }
}
