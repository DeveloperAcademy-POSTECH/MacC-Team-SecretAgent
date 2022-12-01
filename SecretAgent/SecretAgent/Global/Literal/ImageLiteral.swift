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

    static var primaryButtonBackground: UIImage { .load(named: "primaryButtonBackground") }
    static var skipButtonImage: UIImage { .load(named: "skipButtonImage") }
    static var storySkipButton: UIImage { .load(named: "storySkipButton") }
    static var preButton: UIImage { .load(named: "preButton") }
    static var nextButton: UIImage { .load(named: "nextButton") }
    static var storyLinesBackground: UIImage { .load(named: "storyLinesBackground") }

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
    static var story: UIImage { .load(named: "story.activate") }
    static var inactiveStory: UIImage { .load(named: "story.deactivate") }

    // MARK: - NavigationBarButton

    static var agent: UIImage { .load(named: "agent") }

    // MARK: - Siren

    static var siren: UIImage { .load(named: "siren") }
    static var woongwoong: UIImage { .load(named: "woongwoong") }

    // MARK: - Secene

    static var scene1: UIImage { .load(named: "Scene1") }
    static var scene2: UIImage { .load(named: "Scene2") }
    static var scene3: UIImage { .load(named: "Scene3") }
    static var scene4: UIImage { .load(named: "Scene4") }
    static var scene5: UIImage { .load(named: "Scene5") }
    static var scene6: UIImage { .load(named: "Scene6") }
    static var scene7: UIImage { .load(named: "Scene7") }
    static var scene8: UIImage { .load(named: "Scene8") }
    static var scene9: UIImage { .load(named: "Scene9") }
    static var scene10: UIImage { .load(named: "Scene10") }
    static var scene11: UIImage { .load(named: "Scene11") }
    static var scene12: UIImage { .load(named: "Scene12") }

    // MARK: - StoryTab

    static var biyoPlayButton: UIImage { .load(named: "biyoPlayButton") }
    static var kiyoPlayButton: UIImage { .load(named: "kiyoPlayButton") }
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
