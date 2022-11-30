//
//  StarCollectCongratsViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

import SnapKit

final class StarCollectCongratsViewController: BaseViewController {
    // MARK: - Properties
    
    var badgeType: BadgeType = .poyoStar
    
    // MARK: - UI Properties
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .largeTitle))), for: .normal)
        button.imageView?.tintColor = .black
        button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        return button
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "OO스타 획득!"
        label.font = UIFont.oneMobile(size: 40)
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
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
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
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.trailing.equalToSuperview().inset(30)
        }
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(125)
            make.centerX.equalToSuperview()
        }
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(collectButton)
        collectButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(90)
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
        print("dismiss")
        dismiss(animated: true)
    }
}
