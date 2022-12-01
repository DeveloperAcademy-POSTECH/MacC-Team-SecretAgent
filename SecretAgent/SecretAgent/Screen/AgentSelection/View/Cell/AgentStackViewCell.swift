//
//  AgentStackViewCell.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

final class AgentStackViewCell: UIButton {
    // MARK: - UI Properties
    
    private let agentImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Init
    
    init(agentID: Int) {
        super.init(frame: .zero)
        tag = agentID
        agentImageView.image = Agent.agentList[tag].basicImage
        render()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubview(agentImageView)
        
        agentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    func selectAgent() {
        agentImageView.image = Agent.agentList[tag].selectedImage
    }
    
    func unselectAgent() {
        agentImageView.image = Agent.agentList[tag].disabledImage
    }
}
