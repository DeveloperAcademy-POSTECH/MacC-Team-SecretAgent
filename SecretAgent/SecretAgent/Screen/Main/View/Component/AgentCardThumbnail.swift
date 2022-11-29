//
//  AgentCard.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/28.
//

import UIKit

// MARK: - Literal

private enum Literal: String {
    case agentCard = "요원증"

    func callAsFunction() -> String {
        return rawValue
    }
}

final class AgentCardThumbnailView: UIStackView {
    // MARK: - Properties

    let agentCardImageView = UIImageView(image: ImageLiteral.agent)
    let agentCardLabel = UILabel()

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        setAgentCard()
        axis = .vertical
        distribution = .equalSpacing
    }

    private func setAgentCard() {
        agentCardLabel.text = Literal.agentCard()
        agentCardLabel.font = .regularCaption2
        agentCardLabel.textAlignment = .center
        [agentCardImageView, agentCardLabel].forEach { subView in
            addArrangedSubview(subView)
        }
    }
}
