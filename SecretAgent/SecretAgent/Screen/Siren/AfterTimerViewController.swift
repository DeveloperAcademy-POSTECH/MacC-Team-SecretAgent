//
//  AfterTimerViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

class AfterTimerViewController: BaseViewController {

    // MARK: - Properties

    private let mainLabel = {
        let label = UILabel()
        label.text = "타임아웃!"
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()

    private let subLabel = {
        let label = UILabel()
        label.text = "꼬마요원이 15분동안 조용히 기지를 잘 지켰나요?"
        label.font = .regularBody
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private let labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()

    private let successButton: UIButton = {
        let button = UIButton()
        button.setTitle("성공! (일일획득코인 유지)", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 16
        return button
    }()

    private let failButton: UIButton = {
        let button = UIButton()
        button.setTitle("실패! (일일획득코인 1 차감)", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.orange.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 16
        return button
    }()

    private let buttonVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func render() {
        labelVStackView.addArrangedSubview(mainLabel)
        labelVStackView.addArrangedSubview(subLabel)
        view.addSubview(labelVStackView)

        labelVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(71)
            make.top.equalToSuperview().offset(144)
        }

        buttonVStackView.addArrangedSubview(successButton)
        successButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(61)
        }
        buttonVStackView.addArrangedSubview(failButton)
        failButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(61)
        }
        view.addSubview(buttonVStackView)

        buttonVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(84)
        }
    }

    override func configUI() {
        super.configUI()
    }

}
