//
//  CommonBadgeInfoComponent.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

final class CommonBadgeInfoComponent: UIView {
    // MARK: - UI Properties

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.oneMobile(size: 14)
        return label
    }()

    private let badgeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Life Cycle

    init(image: UIImage) {
        badgeImage.image = image
        super.init(frame: .zero)
        render()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Func

    private func render() {
        addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
        }

        addSubview(badgeImage)
        badgeImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(10)
            make.width.equalTo(24)
        }
    }
}
