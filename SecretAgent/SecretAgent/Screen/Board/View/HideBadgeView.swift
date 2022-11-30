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
        imageView.image = UIImage(systemName: "lock.fill", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))
        imageView.tintColor = .white
        return imageView
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "이전 스타뱃지를 \n 획득해야 시작할 수 있어요!"
        label.font = UIFont.oneMobile(size: 23)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let backgroundView = UIView()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView.backgroundColor = .yoGray6.withAlphaComponent(0.3)
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addSubview(lockImage)
        lockImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(infoLabel.snp.top).offset(-20)
        }   
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
