//
//  StoryCell.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/12/01.
//

import UIKit

import SnapKit

class StoryCell: UIButton {
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .regularSubheadline
        label.textColor = .yoGray5
        return label
    }()

    let centerLabel: UILabel = {
        let label = UILabel()
        label.font = .oneMobile(size: 22)
        label.numberOfLines = 2
        return label
    }()

    init(image: UIImage, subTitle: String, title: String) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
        subTitleLabel.text = subTitle
        centerLabel.text = title

        addSubview(centerLabel)
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(69)
            make.leading.equalTo(25)
        }

        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(45)
            make.leading.equalTo(25)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
