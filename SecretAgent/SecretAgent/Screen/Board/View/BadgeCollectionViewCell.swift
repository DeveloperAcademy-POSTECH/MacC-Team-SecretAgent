//
//  BadgeCollectionViewCell.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

private enum BadgeSize {
    static let badgeWidth: Double = 90
    static let badgeHeight: Double = 96.15
}

class BadgeCollectionViewCell: UICollectionViewCell {
    static let identifier = "BadgeCollectionViewCell"

    let badgeImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeImageView)
        badgeImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.width.equalTo(BadgeSize.badgeWidth)
            make.height.equalTo(BadgeSize.badgeHeight)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
