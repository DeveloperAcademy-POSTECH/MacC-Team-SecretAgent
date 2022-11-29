//
//  AgentStackViewCell.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

private enum CellSize {
    static let height: Double = UIScreen.main.bounds.height / 5.59
    static let width: Double = UIScreen.main.bounds.width / 2.52
}

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
    
    func selectAgent() {
        agentImageView.image = Agent.agentList[tag].selectedImage
    }
    
    func unselectAgent() {
        agentImageView.image = Agent.agentList[tag].disabledImage
    }
}