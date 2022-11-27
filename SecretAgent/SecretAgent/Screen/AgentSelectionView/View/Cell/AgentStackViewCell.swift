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
    // MARK: - Properties
    
    let agentBasicImageList: [UIImage] = [
        ImageLiteral.agentPoyo,
        ImageLiteral.agentBiyo,
        ImageLiteral.agentKiyo,
        ImageLiteral.agentMayo
    ]
    
    let agentSelectedImageList: [UIImage] = [
        ImageLiteral.agentPoyoSelected,
        ImageLiteral.agentBiyoSelected,
        ImageLiteral.agentKiyoSelected,
        ImageLiteral.agentMayoSelected
    ]
    
    let agentDisabledImageList: [UIImage] = [
        ImageLiteral.agentPoyoDisabled,
        ImageLiteral.agentBiyoDisabled,
        ImageLiteral.agentKiyoDisabled,
        ImageLiteral.agentMayoDisabled
    ]
    
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
        agentImageView.image = agentBasicImageList[agentID]
    }
    
    func selectAgent() {
        agentImageView.image = agentSelectedImageList[tag]
    }
    
    func unselectAgent() {
        agentImageView.image = agentDisabledImageList[tag]
    }
}
