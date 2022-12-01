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
    static var agentPoyoCircleProfile: UIImage { .load(named: "CharProfile-Poyo-Circle-Profile") }
    static var agentBiyoCircleProfile: UIImage { .load(named: "CharProfile-Biyo-Circle-Profile") }
    static var agentKiyoCircleProfile: UIImage { .load(named: "CharProfile-Kiyo-Circle-Profile") }
    static var agentMayoCircleProfile: UIImage { .load(named: "CharProfile-Mayo-Circle-Profile") }

    static var yohanKo: UIImage { .load(named: "yohanKo") }

    // MARK: - Badges

    static var coin: UIImage { .load(named: "coin.activate") }
    static var smallCoin: UIImage { .load(named: "coin.small") }
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
    static var sirenTab: UIImage { .load(named: "beacon.max.fill") }
    static var inactiveSirenTab: UIImage { .load(named: "beacon.max") }
    static var storyTab: UIImage { .load(named: "story.activate", color: .yoYellow1) }
    static var inactiveStoryTab: UIImage { .load(named: "story.deactivate", color: .yoGray4) }
    static var story: UIImage { .load(named: "story.activate") }
    static var inactiveStory: UIImage { .load(named: "story.deactivate") }

    // MARK: - NavigationBarButton

    static var agent: UIImage { .load(named: "agent") }

    // MARK: - Siren

    static var siren: UIImage { .load(named: "sirenImage") }
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

    // MARK: - AgentCard

    static var ggoyosLogo: UIImage { .load(named: "ggoyos.logo") }
    static var divider: UIImage { .load(named: "divider") }
    static var cancelWhite: UIImage { .load(named: "x.white") }
    static var agentCardBackground: UIImage { .load(named: "agentCard.background") }
    static var speech: UIImage { .load(named: "speechImage") }
    static var speech2: UIImage { .load(named: "speechImage2") }

    // MARK: - Timer

    static var timerFail: UIImage { .load(named: "timerFail") }
    static var timerSuccess: UIImage { .load(named: "timerSuccess") }
    static var timerTimeOut: UIImage { .load(named: "timerTimeOut") }
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
