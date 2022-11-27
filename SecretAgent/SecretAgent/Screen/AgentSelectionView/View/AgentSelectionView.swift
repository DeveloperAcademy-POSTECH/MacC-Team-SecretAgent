//
//  AgentSelectionView.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

import SnapKit

private enum FontSize {
    static let largeTitle: Double = 30
}

private enum ViewSize {
    static let stackSpacing: Double = 14
    static let informationLabelY: Double = 140
    static let agentVStackTopOffset: Double = 33
    static let agentVStackWidth: Double = 338
    static let agentVStackHeight: Double = 328
    static let selectedAgentNameLabelBottomInset: Double = 222
    static let selectedAgentDescriptionLabelTopOffset: Double = 22
    static let selectButtonBottomInset: Double = 74
}

class AgentSelectionView: BaseViewController {
    // MARK: - Properties
    
    var selectedAgentID: Int = 0
    
    // MARK: - UI Properties
    
    let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 요원으로\n시작할까?"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: FontSize.largeTitle)
        return label
    }()
    
    let agentStackViewCells: [AgentStackViewCell] = [
        AgentStackViewCell(frame: .zero),
        AgentStackViewCell(frame: .zero),
        AgentStackViewCell(frame: .zero),
        AgentStackViewCell(frame: .zero)
    ]
    
    var agent1stHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        return stackView
    }()
    
    var agent2ndHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        return stackView
    }()
    
    var agentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    let selectedAgentNameLabel: UILabel = {
        let label = UILabel()
        label.text = "O요"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: FontSize.largeTitle)
        return label
    }()
    
    let selectedAgentDecriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "OOO 요원 O요! "
        label.numberOfLines = 2
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var selectButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "선택완료!", color: .systemGray4)
        button.setButtonTextColor(color: .white)
        button.makeButtonSmall()
        button.isEnabled = false
        button.addTarget(self, action: #selector(selectCompleteClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lift Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configStack()
    }
    
    override func render() {
        view.addSubview(informationLabel)
        informationLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(ViewSize.informationLabelY)
        }
        
        view.addSubview(agentVStack)
        agentVStack.snp.makeConstraints { make in
            make.top.equalTo(informationLabel.snp.bottom).offset(ViewSize.agentVStackTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(ViewSize.agentVStackWidth)
            make.height.equalTo(ViewSize.agentVStackHeight)
        }
        
        view.addSubview(selectedAgentNameLabel)
        selectedAgentNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewSize.selectedAgentNameLabelBottomInset)
        }
        
        view.addSubview(selectedAgentDecriptionLabel)
        selectedAgentDecriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(selectedAgentNameLabel.snp.bottom).offset(ViewSize.selectedAgentDescriptionLabelTopOffset)
        }
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewSize.selectButtonBottomInset)
        }
    }
    
    override func configUI() {
        view.backgroundColor = .white
    }
    
    private func configStack() {
        for cellID in 0 ..< 4 {
            if cellID < 2 {
                agent1stHStack.addArrangedSubview(agentStackViewCells[cellID])
            } else {
                agent2ndHStack.addArrangedSubview(agentStackViewCells[cellID])
            }
            
            agentStackViewCells[cellID].setAgentImage(agentID: cellID)
            agentStackViewCells[cellID].addTarget(self, action: #selector(agentClicked), for: .touchUpInside)
        }
        
        agentVStack.addArrangedSubview(agent1stHStack)
        agentVStack.addArrangedSubview(agent2ndHStack)
    }
    
    // MARK: - Func
    
    @objc func agentClicked(sender: UIButton) {
        selectedAgentID = sender.tag
        
        selectedAgentNameLabel.text = Agent.agentList[selectedAgentID].name
        selectedAgentDecriptionLabel.text = Agent.agentList[selectedAgentID].description
        
        selectedAgentNameLabel.isHidden = false
        selectedAgentDecriptionLabel.isHidden = false
        
        selectButton.setButtonColor(color: .orange)
        selectButton.isEnabled = true
        
        agentStackViewCells[selectedAgentID].selectAgent()
        
        for agentID in 0 ..< 4 where agentID != selectedAgentID {
            agentStackViewCells[agentID].unselectAgent()
        }
    }
    
    @objc func selectCompleteClicked(sender: UIButton) {
        // TODO: - 완료 버튼 구현 예정
        print(Agent.agentList[selectedAgentID].name, "선택완료")
    }
}
