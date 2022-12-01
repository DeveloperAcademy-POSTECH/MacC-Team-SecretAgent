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
    static let mentSize = CGSize(width: 170, height: 87)
}

class BadgeCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    var badgeType: BadgeType? = .coin

    private let badgeImageView = UIImageView()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeImageView)
    }

    // MARK: - Func

    func generateActiveImage() {
        badgeImageView.image = badgeType?.badgeActiveImage
    }

    func generateInactiveImage() {
        badgeImageView.image = badgeType?.badgeInactiveImage
    }

    func generateLastImage() {
        badgeImageView.image = ImageLiteral.allStarCompletedMent
    }

    func generateLastImageTransparent() {
        badgeImageView.image = ImageLiteral.allStarCompletedMentTransparent
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
        case .star, .poyoStar, .biyoStar, .kiyoStar, .mayoStar, .allStar:
            badgeWidth = BadgeSize.starSize.width
            badgeImageView.frame.size.width = BadgeSize.starSize.width
            badgeImageView.frame.size.height = BadgeSize.starSize.height
        case .none:
            badgeWidth = BadgeSize.mentSize.width
            badgeImageView.frame.size.width = BadgeSize.mentSize.width
            badgeImageView.frame.size.height = BadgeSize.mentSize.height
        }
        badgeImageView.frame.origin = .init(x: frame.origin.x + frame.size.width - badgeWidth, y: 0)
    }

    func getBadgeWidth() -> Double {
        switch badgeType {
        case .coin:
            return BadgeSize.coinSize.width
        case .shield:
            return BadgeSize.shieldSize.width
        case .none:
            return BadgeSize.mentSize.width
        case .star, .poyoStar, .biyoStar, .kiyoStar, .mayoStar, .allStar:
            return BadgeSize.starSize.width
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
