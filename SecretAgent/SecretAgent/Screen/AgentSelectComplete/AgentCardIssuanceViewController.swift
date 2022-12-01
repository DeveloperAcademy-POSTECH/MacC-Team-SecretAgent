//
//  AgentCardIssuanceViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/27.
//

import UIKit

import SnapKit

private enum FontSize {
    static let largeTitle: Double = 30
}

private enum ViewSize {
    static let topLabelTopInset: Double = UIScreen.main.bounds.height / 6.44
    static let agentCardTopOffset: Double = UIScreen.main.bounds.height / 20.59
    static let agentCardWidth: Double = UIScreen.main.bounds.width / 1.82 * 1.1
    static let agentCardHeight: Double = UIScreen.main.bounds.height / 2.38 * 1.1
    static let actionButtonBottomInset: Double = UIScreen.main.bounds.height * 0.12
}

class AgentCardIssuanceViewController: BaseViewController {
    // MARK: - Properties
    
    // MARK: - UI Properties
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = .oneMobile(size: 30)
        label.numberOfLines = 2
        label.text = "요원 O요\n출동!"
        label.textAlignment = .center
        return label
    }()
    
    // TODO: - 현재 예시로 이미지를 넣은 상태이며 요원증 뷰가 만들어지는대로 적용할 예정입니다.
//    let agentCard: UIView = {
//        let view = UIView()
//        let imageView = AgentCardView(frame: CGRect(x: 0, y: 0, width: ViewSize.agentCardWidth, height: ViewSize.agentCardHeight))
//        imageView.setCompact()
//        view.addSubview(imageView)
//        return view
//    }()
    let agentCard: UIImageView = {
        let imageView = AgentCardView(frame: CGRect(x: 0, y: 0, width: ViewSize.agentCardWidth, height: ViewSize.agentCardHeight))
        imageView.setCompact()
        return imageView
    }()
    
    let actionButton: BaseButton = {
        let button = BaseButton()
        button.makeButtonLarge()
        button.setButton(text: "출동하기", color: .yoBlack)
        button.setBackgroundImage(ImageLiteral.primaryButtonBackground, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func render() {
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(ViewSize.topLabelTopInset)
        }
        
        view.addSubview(agentCard)
        agentCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(0.546)
            make.height.equalToSuperview().multipliedBy(0.49)
        }
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewSize.actionButtonBottomInset)
        }
    }
    
    override func configUI() {
        guard let agentName = UserDefaults.standard.string(forKey: "agentName") else { return }

        topLabel.text = "요원 \(agentName)\n출동!"
    }
}
