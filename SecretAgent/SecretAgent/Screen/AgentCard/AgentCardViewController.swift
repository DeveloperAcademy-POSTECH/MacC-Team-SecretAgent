//
//  AgentCardViewController.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/30.
//

import UIKit

import SnapKit

private enum Literal {
    static let agentCard = "요원증"
}

class AgentCardViewController: BaseViewController {
    // MARK: - Properties

    private let agentCardImageView = AgentCardView()

    private let cancelButton: UIButton = {
        let image = ImageLiteral.cancelWhite
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return button
    }()

    private let navigationTitle: UILabel = {
        let label = UILabel()
        label.text = Literal.agentCard
        label.textColor = .white
        label.font = .boldBody
        return label
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Func

    override func render() {
        view.addSubview(navigationTitle)
        navigationTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(59)
            make.centerX.equalToSuperview()
        }

        view.addSubview(agentCardImageView)
        agentCardImageView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(14)
            make.height.equalToSuperview().multipliedBy(0.77)
            make.horizontalEdges.equalToSuperview().inset(26)
        }

        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(74)
            make.trailing.equalToSuperview().inset(24)
        }
    }

    override func configUI() {
        view.backgroundColor = .yoBlack
    }

    // TODO: - 함수 구현
    @objc func dismissModal() {
        dismiss(animated: true)
    }
}
