//
//  AgentSelectionViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/26.
//

import UIKit

private enum FontSize {
    static let largeTitle: Double = 30
}

private enum ViewSize {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let isLandscapeToPortrait = UIScreen.main.bounds.height > UIScreen.main.bounds.width
    
    static let stackSpacing: Double = isLandscapeToPortrait ? screenWidth / 27.86 : screenHeight / 27.86
    static let informationLabelY: Double = isLandscapeToPortrait ? (screenHeight / screenWidth > 2 ? screenHeight / 6.03 : screenHeight / 8) : (screenWidth / screenHeight > 2 ? screenWidth / 6.03 : screenWidth / 8)
    static let agentVStackTopOffset: Double = isLandscapeToPortrait ? screenWidth / 25.58 : screenHeight / 25.58
    static let agentVStackWidth: Double = isLandscapeToPortrait ? (screenHeight / screenWidth > 2 ? screenWidth / 1.15 : screenHeight / 2.57) : (screenWidth / screenHeight > 2 ? screenHeight / 1.15 : screenWidth / 2.57)
    static let agentVStackHeight: Double = isLandscapeToPortrait ? screenHeight / 2.57 : screenWidth / 2.57
    static let selectedAgentNameLabelBottomInset: Double = isLandscapeToPortrait ? screenHeight / 3.80 : screenWidth / 3.80
    static let selectedAgentDescriptionLabelTopOffset: Double = isLandscapeToPortrait ? screenHeight / 38.36 : screenWidth / 38.36
    static let selectButtonBottomInset: Double = isLandscapeToPortrait ? screenHeight / 11.41 : screenWidth / 11.41
}

final class AgentSelectionViewController: BaseViewController {
    // MARK: - Properties
    
    private var selectedAgentID: Int = 0
    
    // MARK: - UI Properties
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 요원으로\n시작할까?"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: FontSize.largeTitle)
        return label
    }()
    
    private let agentStackViewCells: [AgentStackViewCell] = [
        AgentStackViewCell(agentID: 0),
        AgentStackViewCell(agentID: 1),
        AgentStackViewCell(agentID: 2),
        AgentStackViewCell(agentID: 3)
    ]
    
    private var agentUpperHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        return stackView
    }()
    
    private var agentLowerHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        return stackView
    }()
    
    private var agentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = ViewSize.stackSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    private let selectedAgentNameLabel: UILabel = {
        let label = UILabel()
        label.text = "O요"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: FontSize.largeTitle)
        return label
    }()
    
    private let selectedAgentDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "OOO 요원 O요! "
        label.numberOfLines = 2
        label.isHidden = true
        label.textAlignment = .center
        return label
    }()
    
    private lazy var selectButton: BaseButton = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
        
        view.addSubview(selectedAgentDescriptionLabel)
        selectedAgentDescriptionLabel.snp.makeConstraints { make in
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
        for cellID in agentStackViewCells.indices {
            if cellID < 2 {
                agentUpperHStack.addArrangedSubview(agentStackViewCells[cellID])
            } else {
                agentLowerHStack.addArrangedSubview(agentStackViewCells[cellID])
            }
            
            agentStackViewCells[cellID].addTarget(self, action: #selector(agentClicked), for: .touchUpInside)
        }
        
        agentVStack.addArrangedSubview(agentUpperHStack)
        agentVStack.addArrangedSubview(agentLowerHStack)
    }
    
    // MARK: - Func
    
    @objc private func agentClicked(sender: UIButton) {
        selectedAgentID = sender.tag
        
        selectedAgentNameLabel.text = Agent.agentList[selectedAgentID].name
        selectedAgentDescriptionLabel.text = Agent.agentList[selectedAgentID].description
        
        selectedAgentNameLabel.isHidden = false
        selectedAgentDescriptionLabel.isHidden = false
        
        selectButton.setButtonColor(color: .orange)
        selectButton.isEnabled = true
        
        agentStackViewCells[selectedAgentID].selectAgent()
        
        for agentID in 0 ..< 4 where agentID != selectedAgentID {
            agentStackViewCells[agentID].unselectAgent()
        }
    }
    
    @objc private func selectCompleteClicked(sender: UIButton) {
        // TODO: - 완료 버튼 구현 예정
        print(Agent.agentList[selectedAgentID].name, "선택완료")
    }
}
