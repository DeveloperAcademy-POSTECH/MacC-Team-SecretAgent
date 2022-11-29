//
//  HideBadgeView.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/29.
//

import UIKit

import SnapKit

final class HideBadgeView: UIView {
    // MARK: - Properties
    
    private let lockImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.agent
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "이전 스타뱃지를 \n 획득해야 시작할 수 있어요!"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(lockImage)
        lockImage.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.top).inset(20)
            make.centerX.equalTo(infoLabel)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
