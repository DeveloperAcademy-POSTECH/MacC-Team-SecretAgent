//
//  imageLiteral.swift
//  Gajeongtongsin
//
//  Created by DaeSeong on 2022/07/16.
//

import Foundation
import UIKit

enum ImageLiteral {
    // MARK: - Badges

    static var coin: UIImage { .load(named: "coin.activate") }
    static var strokedCoin: UIImage { .load(named: "coin.stroke") }
    static var shield: UIImage { .load(named: "shield.activate") }
    static var star: UIImage { .load(named: "star.activate") }
    static var inactiveCoin: UIImage { .load(named: "coin.deactivate") }
    static var inactiveShield: UIImage { .load(named: "shield.deactivate") }
    static var inactiveStar: UIImage { .load(named: "star.deactivate") }

    // MARK: - TabBar

    static var boardTab: UIImage { .load(systemName: "star.circle.fill", color: .yoYellow1) }
    static var inactiveBoardTab: UIImage { .load(systemName: "star.circle", color: .yoGray4) }
    static var sirenTab: UIImage { .load(systemName: "light.beacon.max.fill", color: .yoYellow1) }
    static var inactiveSirenTab: UIImage { .load(systemName: "light.beacon.max", color: .yoGray4) }
    static var storyTab: UIImage { .load(named: "story.activate", color: .yoYellow1) }
    static var inactiveStoryTab: UIImage { .load(named: "story.deactivate", color: .yoGray4) }

    // MARK: - NavigationBarButton

    static var agent: UIImage { .load(named: "agent") }

    // MARK: - Siren

    static var siren: UIImage { .load(named: "siren") }
    static var woongwoong: UIImage { .load(named: "woongwoong") }
}

extension UIImage {
    static func load(named imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            return UIImage()
        }
        image.accessibilityIdentifier = imageName
        return image
    }

    static func load(systemName: String) -> UIImage {
        guard let image = UIImage(systemName: systemName, compatibleWith: nil) else {
            return UIImage()
        }
        image.accessibilityIdentifier = systemName
        return image
    }

    static func load(named: String, color: UIColor) -> UIImage {
        return UIImage.load(named: named).withTintColor(color)
    }

    static func load(systemName: String, color: UIColor) -> UIImage {
        return UIImage.load(systemName: systemName).withTintColor(color)
    }
}
