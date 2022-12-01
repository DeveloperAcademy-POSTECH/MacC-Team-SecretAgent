//
//  BaseButton.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

import SnapKit

private enum ButtonSize {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let isPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
    
    static let largeButtonWidth = isPortrait ? screenWidth * 0.846 : screenHeight * 0.846
    static let smallButtonWidth = isPortrait ? screenWidth / 2.6 : screenHeight / 2.6
    static let largeButtonHeight = isPortrait ? screenHeight * 0.083 : screenWidth * 0.083
    static let smallButtonHeight = isPortrait ? screenHeight / 14.07 : screenWidth / 14.07
    static let borderWidth: Double = 1
    static let cornerRadiusSmall: Double = 18
    static let cornerRadiusLarge: Double = 16
}

class BaseButton: UIButton {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = ButtonSize.cornerRadiusSmall
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        layer.masksToBounds = true
        layer.cornerRadius = ButtonSize.cornerRadiusSmall
    }
    
    // MARK: - Func
    
    func setButton(text: String, color: UIColor) {
        setTitle(text, for: .normal)
        titleLabel?.font = .oneMobile(textStyle: .body)
        backgroundColor = color
    }
    
    func setButtonBorder(color: CGColor) {
        backgroundColor = .white
        layer.borderWidth = ButtonSize.borderWidth
        layer.borderColor = color
    }
    
    func setButtonColor(color: UIColor) {
        backgroundColor = color
    }
    
    func setButtonTextColor(color: UIColor) {
        setTitleColor(color, for: .normal)
    }
    
    func makeButtonLarge() {
        layer.cornerRadius = ButtonSize.cornerRadiusLarge
        
        snp.makeConstraints { make in
            make.width.equalTo(ButtonSize.largeButtonWidth)
            make.height.equalTo(ButtonSize.largeButtonHeight)
        }
    }
    
    func makeButtonSmall() {
        layer.cornerRadius = ButtonSize.cornerRadiusSmall
        
        snp.makeConstraints { make in
            make.width.equalTo(ButtonSize.smallButtonWidth)
            make.height.equalTo(ButtonSize.smallButtonHeight)
        }
    }
}
