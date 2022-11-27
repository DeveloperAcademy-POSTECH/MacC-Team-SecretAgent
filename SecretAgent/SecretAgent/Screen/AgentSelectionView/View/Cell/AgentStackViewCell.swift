//
//  AgentStackViewCell.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

private enum CellSize {
    static let height: Double = 151
    static let width: Double = 155
}

class AgentStackViewCell: UIButton {
    // MARK: - UI Properties
    
    let agentImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
        snp.makeConstraints { make in
            make.width.equalTo(CellSize.width)
            make.height.equalTo(CellSize.height)
        }
        
        addSubview(agentImageView)
        
        agentImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    func setAgentImage(agentID: Int) {
        tag = agentID
        agentImageView.image = Agent.agentList[tag].basicImage
    }
    
    func selectAgent() {
        agentImageView.image = Agent.agentList[tag].selectedImage
    }
    
    func unselectAgent() {
        agentImageView.image = Agent.agentList[tag].disabledImage
    }
}
