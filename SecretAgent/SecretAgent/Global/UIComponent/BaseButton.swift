//
//  BaseButton.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

import SnapKit

private enum ButtonSize {
    static let largeButtonWidth: Double = UIScreen.main.bounds.width / 1.11
    static let smallButtonWidth: Double = UIScreen.main.bounds.width / 2.6
    static let height: Double = UIScreen.main.bounds.height / 14.07
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Func
    
    func setButton(text: String, color: UIColor) {
        setTitle(text, for: .normal)
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
            make.height.equalTo(ButtonSize.height)
        }
    }
    
    func makeButtonSmall() {
        layer.cornerRadius = ButtonSize.cornerRadiusSmall
        
        snp.makeConstraints { make in
            make.width.equalTo(ButtonSize.smallButtonWidth)
            make.height.equalTo(ButtonSize.height)
        }
    }
}
