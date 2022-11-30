//
//  onBoardingTableViewCell.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/30.
//

import UIKit

import SnapKit

private enum FontSize {}

private enum ViewSize {
    static let leadingInset = UIScreen.main.bounds.width / 13
    static let bodyWidth = UIScreen.main.bounds.width - 2 * leadingInset
    
    static let cornerRadius: Double = 15
    static let stepLabelSize: CGSize = .init(width: 3 * UIScreen.main.bounds.width / 13, height: UIScreen.main.bounds.width / 13)
    static let stepLabelTopOffset: Double = UIScreen.main.bounds.height / 19.18
    static let contentLabelBottomInset: Double = UIScreen.main.bounds.height / 19.18
    static let bodyTopOffset: Double = UIScreen.main.bounds.height / 52.75
}

class OnBoardingTableViewCell: UITableViewCell {
    // MARK: - Properties
    
    let cellIdentifier: String = "onBoardingTableViewCell"
    
    // MARK: - UI Properties
    
    let stepLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = ViewSize.cornerRadius
        label.layer.masksToBounds = true
        label.textColor = .yoYellow1
        label.textAlignment = .center
        label.layer.borderColor = UIColor.yoYellow1.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldBody
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 7
        return label
    }()
    
    // MARK: - Init
    
    init(stepNo: Int, titleText: String, content: String) {
        super.init(style: .default, reuseIdentifier: cellIdentifier)
        render()
        stepLabel.text = "Step \(stepNo)"
        titleLabel.text = titleText
        contentLabel.text = content
        
        let newSize = contentLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 2 * ViewSize.leadingInset, height: Double.greatestFiniteMagnitude))
        contentLabel.snp.makeConstraints { make in
            make.height.equalTo(newSize.height)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.size.equalTo(ViewSize.stepLabelSize)
            make.top.equalTo(ViewSize.stepLabelTopOffset)
            make.leading.equalToSuperview().inset(ViewSize.leadingInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(stepLabel.snp.bottom).offset(ViewSize.bodyTopOffset)
            make.leading.equalToSuperview().inset(ViewSize.leadingInset)
        }
        
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ViewSize.bodyTopOffset)
            make.leading.trailing.equalToSuperview().inset(ViewSize.leadingInset)
            make.bottom.equalToSuperview().inset(ViewSize.contentLabelBottomInset)
        }
    }
    
    // MARK: - Func
}
