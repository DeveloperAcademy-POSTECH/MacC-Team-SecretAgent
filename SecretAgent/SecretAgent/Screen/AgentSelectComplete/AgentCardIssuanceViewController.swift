//
//  AgentCardIssuanceViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/27.
//

import UIKit

private enum FontSize {
    static let largeTitle: Double = 30
}

private enum ViewSize {
    static let topLabelTopInset: Double = UIScreen.main.bounds.height / 6.44
    static let agentCardTopOffset: Double = UIScreen.main.bounds.height / 20.59
    static let agentCardWidth: Double = UIScreen.main.bounds.width / 1.82
    static let agentCardHeight: Double = UIScreen.main.bounds.height / 2.38
    static let actionButtonBottomInset: Double = UIScreen.main.bounds.height / 8.36
}

class AgentCardIssuanceViewController: BaseViewController {
    // MARK: - Properties
    
    let agentName: String = "키요"
    
    // MARK: - UI Properties
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.largeTitle)
        label.numberOfLines = 2
        label.text = "요원 O요\n출동!"
        label.textAlignment = .center
        return label
    }()
    
    // TODO: - 현재 예시로 이미지를 넣은 상태이며 요원증 뷰가 만들어지는대로 적용할 예정입니다.
    let agentCard: UIView = {
        let view = UIView()
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ViewSize.agentCardWidth, height: ViewSize.agentCardHeight))
        imageView.image = UIImage(named: "agentCardEx")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        return view
    }()
    
    let actionButton: BaseButton = {
        let button = BaseButton()
        button.makeButtonLarge()
        button.setButton(text: "출동하기", color: .clear)
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
            make.top.equalTo(topLabel.snp.bottom).offset(ViewSize.agentCardTopOffset)
            make.width.equalTo(ViewSize.agentCardWidth)
            make.height.equalTo(ViewSize.agentCardHeight)
        }
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewSize.actionButtonBottomInset)
        }
    }
    
    override func configUI() {
        topLabel.text = "요원 \(agentName)\n출동!"
    }
}
