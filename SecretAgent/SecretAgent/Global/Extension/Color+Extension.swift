//
//  Color+Extension.swift
//  Samplero
//
//  Created by DaeSeong on 2022/10/07.
//

import UIKit

extension UIColor {
    //  에셋 컬러 사용 예시\
    static let accent: UIColor = .init(hex: "2F2B2B")
    static let boxBackground: UIColor = .secondarySystemBackground
    static let primaryBlack: UIColor = .black
    static let secondaryGray: UIColor = .secondaryLabel

    // 헥사코드 컬러 사용 예시
    static let addedButtonGray: UIColor = .init(hex: "F5F5F5")
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
