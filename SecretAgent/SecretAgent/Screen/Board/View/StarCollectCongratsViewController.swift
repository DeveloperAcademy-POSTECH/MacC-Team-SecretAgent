//
//  StarCollectCongratsViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

import SnapKit

// TODO: - 상수 값 enum으로 빼기

protocol StarCollectCongratsViewDelegate {
    func whatToDoAfterStarModal()
}

private enum CongratsViewSize {
    static let mainLabelFontSize: Double = 40
    static let xButtonTopInset = 60
    static let xButtonTrailingInset = 30
    static let mainLabelTopInset = 125
    static let subLabelTopOffset = 25
    static let lowerButtonBottomInset = 90
}

final class StarCollectCongratsViewController: BaseViewController {
    // MARK: - Properties
    
    var delegate: StarCollectCongratsViewDelegate?
    
    var badgeType: BadgeType = .poyoStar {
        didSet {
            setStarName()
            setBackgroundImage()
        }
    }
    
    // MARK: - UI Properties
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "OO스타 획득!"
        label.font = UIFont.oneMobile(size: CongratsViewSize.mainLabelFontSize)
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "임무를 완수한 아이에게\n선물을 주시는 건 어떠신가요?"
        label.font = UIFont.regularBody
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "확인", color: UIColor.yoGray6)
        button.setButtonTextColor(color: .white)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.makeButtonLarge()
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundImage()
        setStarName()
    }
    
    override func render() {
        view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(CongratsViewSize.mainLabelTopInset)
            make.centerX.equalToSuperview()
        }
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(CongratsViewSize.subLabelTopOffset)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectButton)
        collectButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(CongratsViewSize.lowerButtonBottomInset)
            make.centerX.equalToSuperview()
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    func setBackgroundImage() {
        backgroundImage.image = badgeType.backgroundStarImage
    }
    
    func setStarName() {
        mainLabel.text = "\(badgeType.starBadgeName ?? "축 ")스타 획득"
    }
    
    @objc func closeModal() {
        dismiss(animated: true)
        delegate?.whatToDoAfterStarModal()
    }
}
