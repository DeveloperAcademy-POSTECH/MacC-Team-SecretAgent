//
//  CustomCollectionViewCell.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"

    let badgeImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(badgeImageView)
        badgeImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalTo(BoardSize.badgeWidth)
            make.height.equalTo(BoardSize.badgeHeight)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
