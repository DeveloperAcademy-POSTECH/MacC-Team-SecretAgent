//
//  imageLiteral.swift
//  Gajeongtongsin
//
//  Created by DaeSeong on 2022/07/16.
//

import Foundation
import UIKit

enum ImageLiteral {
    // MARK: - Agents

    static var agentPoyo: UIImage { .load(named: "CharProfile-Poyo") }
    static var agentBiyo: UIImage { .load(named: "CharProfile-Biyo") }
    static var agentKiyo: UIImage { .load(named: "CharProfile-Kiyo") }
    static var agentMayo: UIImage { .load(named: "CharProfile-Mayo") }

    static var agentPoyoSelected: UIImage { .load(named: "CharProfile-Poyo-Selected") }
    static var agentBiyoSelected: UIImage { .load(named: "CharProfile-Biyo-Selected") }
    static var agentKiyoSelected: UIImage { .load(named: "CharProfile-Kiyo-Selected") }
    static var agentMayoSelected: UIImage { .load(named: "CharProfile-Mayo-Selected") }

    static var agentPoyoDisabled: UIImage { .load(named: "CharProfile-Poyo-Disabled") }
    static var agentBiyoDisabled: UIImage { .load(named: "CharProfile-Biyo-Disabled") }
    static var agentKiyoDisabled: UIImage { .load(named: "CharProfile-Kiyo-Disabled") }
    static var agentMayoDisabled: UIImage { .load(named: "CharProfile-Mayo-Disabled") }

    // MARK: - Badges

    static var coin: UIImage { .load(named: "coin.activate") }
    static var strokedCoin: UIImage { .load(named: "coin.stroke") }
    static var shield: UIImage { .load(named: "shield.activate") }
    static var star: UIImage { .load(named: "star.activate") }
    static var inactiveCoin: UIImage { .load(named: "coin.deactivate") }
    static var inactiveShield: UIImage { .load(named: "shield.deactivate") }
    static var inactiveStar: UIImage { .load(named: "star.deactivate") }
    static var poyoStar: UIImage { .load(named: "star.poyo.active") }
    static var biyoStar: UIImage { .load(named: "star.biyo.active") }
    static var kiyoStar: UIImage { .load(named: "star.kiyo.active") }
    static var mayoStar: UIImage { .load(named: "star.mayo.active") }
    static var allStar: UIImage { .load(named: "star.all.active") }
    static var inactivePoyoStar: UIImage { .load(named: "star.poyo.inactive") }
    static var inactiveBiyoStar: UIImage { .load(named: "star.biyo.inactive") }
    static var inactiveKiyoStar: UIImage { .load(named: "star.kiyo.inactive") }
    static var inactiveMayoStar: UIImage { .load(named: "star.mayo.inactive") }
    static var inactiveAllStar: UIImage { .load(named: "star.all.inactive") }
    static var poyoStarBackground: UIImage { .load(named: "bg.poyo") }
    static var biyoStarBackground: UIImage { .load(named: "bg.biyo") }
    static var kiyoStarBackground: UIImage { .load(named: "bg.kiyo") }
    static var mayoStarBackground: UIImage { .load(named: "bg.mayo") }
    static var allStarBackground: UIImage { .load(named: "bg.all") }
    static var allStarCompletedMent: UIImage { .load(named: "allStarCompleted") }
    static var allStarCompletedMentTransparent: UIImage { .load(named: "allStarCompletedTransparent") }

    // MARK: - TabBar

    static var boardTab: UIImage { .load(systemName: "star.circle.fill", color: .yoYellow1) }
    static var inactiveBoardTab: UIImage { .load(systemName: "star.circle", color: .yoGray4) }
    static var sirenTab: UIImage { .load(systemName: "light.beacon.max.fill", color: .yoYellow1) }
    static var inactiveSirenTab: UIImage { .load(systemName: "light.beacon.max", color: .yoGray4) }
    static var storyTab: UIImage { .load(named: "story.activate", color: .yoYellow1) }
    static var inactiveStoryTab: UIImage { .load(named: "story.deactivate", color: .yoGray4) }
    static var story: UIImage { .load(named: "story.activate") }
    static var inactiveStory: UIImage { .load(named: "story.deactivate") }

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
