//
//  SoundLiteral.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/22.
//

import Foundation

enum SoundLiteral: String {
    // Story
    case scene1
    case scene2
    case scene3
    case scene4
    case scene5
    case scene6
    case scene7
    case scene8to12

    // OnBoarding
    case character
    case choiceLikeGoOut
    case agentCard

    // Siren
    case siren
    case failure
    case success

    // badge
    case coinCheck
    case starBadgeGain

    func callAsFunction() -> String {
        return rawValue
    }
}

enum MusicExtension: String {
    case mp3

    func callAsFunction() -> String {
        return rawValue
    }
}
