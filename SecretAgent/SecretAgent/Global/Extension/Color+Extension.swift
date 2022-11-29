//
//  Color+Extension.swift
//  Samplero
//
//  Created by DaeSeong on 2022/10/07.
//

import UIKit

extension UIColor {
    //  에셋 컬러 사용 예시
    static let yoYellow1: UIColor = .init(hex: "#FFD541")
    static let yoYellow2: UIColor = .init(hex: "#FFD541").withAlphaComponent(0.5)
    static let yoYellow3: UIColor = .init(hex: "#FFD541").withAlphaComponent(0.2)
    static let yoYellow4: UIColor = .init(hex: "#FFD541").withAlphaComponent(0.1)

    static let yoOrange: UIColor = .init(hex: "FF7051")
    static let yoBlue: UIColor = .init(hex: "#0087D3")
    static let yoSand: UIColor = .init(hex: "#D2A053")
    static let yoNavy: UIColor = .init(hex: "#0F487D")
    static let yoGreen: UIColor = .init(hex: "#07BB65")
    static let yoLightGreen: UIColor = .init(hex: "#90DB31")


    static let yoGray1: UIColor = .init(hex: "#FBFBFB")
    static let yoGray2: UIColor = .init(hex: "#F8F8F8")
    static let yoGray3: UIColor = .init(hex: "#F4F4F4")
    static let yoGray4: UIColor = .init(hex: "#DCDCDC")
    static let yoGray5: UIColor = .init(hex: "#8D8D8D")
    static let yoGray6: UIColor = .init(hex: "#222222")
}

extension UIColor {
    static func load(name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            assertionFailure("\(name) 컬러 로드 실패")
            return UIColor()
        }
        return color
    }
}

extension UIColor {
    convenience init(hex: String, alpha: Double = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: Double(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
