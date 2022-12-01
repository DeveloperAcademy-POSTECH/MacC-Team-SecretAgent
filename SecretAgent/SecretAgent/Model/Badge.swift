//
//  Badge.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

enum BadgeType {
    case coin
    case shield
    case star
    case poyoStar
    case biyoStar
    case kiyoStar
    case mayoStar
    case allStar

    var badgeActiveImage: UIImage {
        switch self {
        case .coin:
            return ImageLiteral.coin
        case .shield:
            return ImageLiteral.shield
        case .star:
            return ImageLiteral.star
        case .poyoStar:
            return ImageLiteral.poyoStar
        case .biyoStar:
            return ImageLiteral.biyoStar
        case .kiyoStar:
            return ImageLiteral.kiyoStar
        case .mayoStar:
            return ImageLiteral.mayoStar
        case .allStar:
            return ImageLiteral.allStar
        }
    }

    var badgeInactiveImage: UIImage {
        switch self {
        case .coin:
            return ImageLiteral.inactiveCoin
        case .shield:
            return ImageLiteral.inactiveShield
        case .star:
            return ImageLiteral.inactiveStar
        case .poyoStar:
            return ImageLiteral.inactivePoyoStar
        case .biyoStar:
            return ImageLiteral.inactiveBiyoStar
        case .kiyoStar:
            return ImageLiteral.inactiveKiyoStar
        case .mayoStar:
            return ImageLiteral.inactiveMayoStar
        case .allStar:
            return ImageLiteral.inactiveAllStar
        }
    }

    var backgroundStarImage: UIImage? {
        switch self {
        case .poyoStar:
            return ImageLiteral.poyoStarBackground
        case .biyoStar:
            return ImageLiteral.biyoStarBackground
        case .kiyoStar:
            return ImageLiteral.kiyoStarBackground
        case .mayoStar:
            return ImageLiteral.mayoStarBackground
        case .allStar:
            return ImageLiteral.allStarBackground
        default:
            return nil
        }
    }

    var starBadgeName: String? {
        switch self {
        case .poyoStar:
            return "포요"
        case .biyoStar:
            return "비요"
        case .kiyoStar:
            return "키요"
        case .mayoStar:
            return "마요"
        case .allStar:
            return "모두"
        default:
            return nil
        }
    }
}
