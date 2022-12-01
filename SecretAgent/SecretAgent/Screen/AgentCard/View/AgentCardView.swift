//
//  AgentCardView.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/30.
//

import UIKit

import SnapKit

enum AgentCardLiteral {
    static let role = "비밀요원"
    static let numberOfDays = "임무 수행 O일째"
}

enum AgentCardSize {
    static let dividerHeight = 1
    static let logoTopInset = 12
    static let logoBottomInset = 22
    static let logoSize = 75
    static let imageHeightRatio = 0.375
    static let imageWidthRatio = 0.593
    static let labelsHeight = 186
    static let footerHeight = 100
    static let stackHeightRatio = 0.8125
    static let nameFontSize = 35.0
}

class AgentCardView: UIImageView {
    typealias Literal = AgentCardLiteral
    typealias Size = AgentCardSize

    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()

    // TODO: Agent 바꾸기

    private let agentImage: UIImageView = {
        let image = ImageLiteral.agentKiyoCircleProfile
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let roleLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.role
        label.font = .regularTitle3
        label.alpha = 0.5

        return label
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "키요"
        label.font = .oneMobile(size: Size.nameFontSize)

        return label
    }()

    // TODO: - Core Data 반영하기

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.03.04 ~"
        label.font = .regularTitle3
        label.alpha = 0.5

        return label
    }()

    private let numberOfDaysLabel: UILabel = {
        let label = UILabel()
        label.text = Literal.numberOfDays
        label.font = .semiBoldTitle3
        label.textColor = .yoSand

        return label
    }()

    private let labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        return stackView
    }()

    private let divider: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .yoSand
        return uiView
    }()

    private let footer = UIView()

    private let ggoyosLogoImage: UIImageView = {
        let image = ImageLiteral.ggoyosLogo
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setAgentCard()
        render()
        configUI()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        [roleLabel, nameLabel, dateLabel, numberOfDaysLabel].forEach { label in
            labelStack.addArrangedSubview(label)
        }

        footer.addSubview(divider)
        footer.addSubview(ggoyosLogoImage)

        divider.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(Size.dividerHeight)
            make.width.equalToSuperview()
        }

        ggoyosLogoImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(Size.logoTopInset)
            make.bottom.equalToSuperview().inset(Size.logoBottomInset)
            make.size.equalTo(Size.logoSize)
        }

        [agentImage, labelStack, footer].forEach { subView in
            vStack.addArrangedSubview(subView)
        }

        agentImage.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Size.imageHeightRatio)
            make.width.equalToSuperview().multipliedBy(Size.imageWidthRatio)
        }

        labelStack.snp.makeConstraints { make in
            make.height.equalTo(Size.labelsHeight)
        }

        footer.snp.makeConstraints { make in
            make.height.equalTo(Size.footerHeight)
            make.width.equalToSuperview()
        }

        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(Size.stackHeightRatio)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }

    private func configUI() {
        contentMode = .scaleToFill
    }

    private func setAgentCard() {
        image = ImageLiteral.agentCardBackground
    }
}
