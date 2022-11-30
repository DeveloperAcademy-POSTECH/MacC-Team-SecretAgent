//
//  NumberCollectionViewCell.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

import SnapKit

class NumberCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Func

    private func render() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    private func configUI() {
        contentView.backgroundColor = .systemGray3
        contentView.layer.cornerRadius = 10
    }

    func configure(with number: Int) {
        titleLabel.text = String(number % 10)
    }
}
