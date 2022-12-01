//
//  AgentSelectionCompleteViewController.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/27.
//

import UIKit

private enum FontSize {
    static let largeTitle: Double = 30
}

private enum ViewSize {
    static let topLabelTopInset: Double = UIScreen.main.bounds.height / 5.59
    static let yohanKoTopOffset: Double = UIScreen.main.bounds.height / 9.7
    static let yohanKoImageSize: Double = UIScreen.main.bounds.height / 3.69
    static let yohanKoImageCornerRadius: Double = yohanKoImageSize / 2
    static let yohanLinesLabelTopOffset: Double = UIScreen.main.bounds.height / 42.2
    static let yohanLinesLabelWidth: Double = UIScreen.main.bounds.width / 1.39
    static let yohanLinesLabelHeight: Double = UIScreen.main.bounds.height / 15.63
    static let goodButtonBottomOffset: Double = UIScreen.main.bounds.height * 0.12
}

final class AgentSelectionCompleteViewController: BaseViewController {
    // MARK: - Properties

    private let agentName: String 

    // MARK: - UI Properties

    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "요원 O요에게"
        label.font = .oneMobile(size: 30)
        return label
    }()

    let yohanImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiteral.yohanKo
        return imageView
    }()

    let yohanLinesLabel: UILabel = {
        let label = UILabel()
        label.text = "축하하네, 자네도 이제 우리 요원이야!!\n잘부탁하며, 앞으로 좋은 요원이 되어주게나~"
        label.textAlignment = .center
        label.font = UIFont.regularFootnote
        label.numberOfLines = 2
        label.backgroundColor = .yoMildBlue
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    let goodButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "좋아요", color: .clear)
        button.makeButtonLarge()
        button.setBackgroundImage(ImageLiteral.primaryButtonBackground, for: .normal)
        return button
    }()

    // MARK: - Init

    init(agentName: String) {
        self.agentName = agentName
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }

    override func render() {
        view.addSubview(topLabel)
        topLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(ViewSize.topLabelTopInset)
        }

        view.addSubview(yohanImageView)
        yohanImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(topLabel.snp.bottom).offset(ViewSize.yohanKoTopOffset)
        }

        view.addSubview(yohanLinesLabel)
        yohanLinesLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(yohanImageView.snp.bottom).offset(ViewSize.yohanLinesLabelTopOffset)
            make.width.equalTo(ViewSize.yohanLinesLabelWidth)
            make.height.equalTo(ViewSize.yohanLinesLabelHeight)
        }

        view.addSubview(goodButton)
        goodButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(ViewSize.goodButtonBottomOffset)
        }
    }

    override func configUI() {
        super.configUI()
        topLabel.text = "요원 \(agentName)에게"

        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .yoBlack
    }

    private func addTargets() {
        goodButton.addTarget(self, action: #selector(goodButtonTapped), for: .touchUpInside)
    }
    
    private func playSound(_ sound: SoundLiteral, _ repeated: Bool = false) {
        SoundManager.shared.setupSound(soundOption: sound, repeated: repeated)
        SoundManager.shared.playSound()
    }

    @objc private func goodButtonTapped() {
        let agentCardIssuanceVC = AgentCardIssuanceViewController(agentName: agentName)
        navigationItem.title = "캐릭터 선택"
        navigationController?.pushViewController(agentCardIssuanceVC, animated: true)
        playSound(.choiceLikeGoOut)
    }
}
