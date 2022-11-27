//
//  BaseButton.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

import SnapKit

private enum ButtonSize {
    static let largeButtonWidth: Double = 350
    static let smallButtonWidth: Double = 150
    static let height: Double = 60
    static let borderWidth: Double = 1
    static let cornerRadius: Double = 18
}

class BaseButton: UIButton {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = ButtonSize.cornerRadius
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
        snp.makeConstraints { make in
            make.width.equalTo(ButtonSize.largeButtonWidth)
            make.height.equalTo(ButtonSize.height)
        }
    }
    
    func makeButtonSmall() {
        snp.makeConstraints { make in
            make.width.equalTo(ButtonSize.smallButtonWidth)
            make.height.equalTo(ButtonSize.height)
        }
    }
}
