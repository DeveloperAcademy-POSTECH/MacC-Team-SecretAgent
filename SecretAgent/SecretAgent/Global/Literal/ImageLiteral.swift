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
    static var shield: UIImage { .load(named: "shield.activate") }
    static var star: UIImage { .load(named: "star.activate") }
    static var deactivateCoin: UIImage { .load(named: "coin.deactivate") }
    static var deactivateShield: UIImage { .load(named: "shield.deactivate") }
    static var deactivateStar: UIImage { .load(named: "star.deactivate") }

    // MARK: - TabBar

    static var story: UIImage { .load(named: "story.activate") }
    static var deactivateStory: UIImage { .load(named: "story.deactivate") }

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
}
