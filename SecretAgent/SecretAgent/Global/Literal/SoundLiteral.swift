//
//  SoundLiteral.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/22.
//

import Foundation

enum SoundLiteral: String {
    case siren

    func fileName() -> String {
        return rawValue + "." + MusicExtension.mp3.rawValue
    }
}

enum MusicExtension: String {
    case mp3
}
