//
//  BadgeCollectionViewCell.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

private enum BadgeSize {
    static let coinSize = CGSize(width: 90, height: 96.15)
    static let shieldSize = CGSize(width: 96, height: 135.17)
    static let starSize = CGSize(width: 163.0, height: 196.0)
}

class BadgeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    static let identifier = "BadgeCollectionViewCell"

    var badgeType: BadgeType = .coin

    var badgeImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeImageView)
        badgeImageView.frame.origin = .init(x: frame.origin.x + frame.size.width / 2, y: 0)
    }

    func generateActiveImage() {
        switch badgeType {
        case .coin:
            badgeImageView.image = ImageLiteral.coin
        case .shield:
            badgeImageView.image = ImageLiteral.shield
        case .star:
            badgeImageView.image = ImageLiteral.star
        }
    }

    func generateInactiveImage() {
        switch badgeType {
        case .coin:
            badgeImageView.image = ImageLiteral.inactiveCoin
        case .shield:
            badgeImageView.image = ImageLiteral.inactiveShield
        case .star:
            badgeImageView.image = ImageLiteral.inactiveStar
        }
    }

    func setImageFrame() {
        var badgeWidth = 0.0
        switch badgeType {
        case .coin:
            badgeWidth = BadgeSize.coinSize.width
            badgeImageView.frame.size.width = BadgeSize.coinSize.width
            badgeImageView.frame.size.height = BadgeSize.coinSize.height
        case .shield:
            badgeWidth = BadgeSize.shieldSize.width
            badgeImageView.frame.size.width = BadgeSize.shieldSize.width
            badgeImageView.frame.size.height = BadgeSize.shieldSize.height
        case .star:
            badgeWidth = BadgeSize.starSize.width
            badgeImageView.frame.size.width = BadgeSize.starSize.width
            badgeImageView.frame.size.height = BadgeSize.starSize.height
        }
        badgeImageView.frame.origin = .init(x: frame.origin.x + frame.size.width - badgeWidth, y: 0)
    }

    func getBadgeWidth() -> Double {
        switch badgeType {
        case .coin:
            return BadgeSize.coinSize.width
        case .shield:
            return BadgeSize.shieldSize.width
        case .star:
            return BadgeSize.starSize.width
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
