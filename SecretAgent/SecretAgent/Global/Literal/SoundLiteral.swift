//
//  SoundLiteral.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/22.
//

import Foundation

enum SoundLiteral: String {
    case siren

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
