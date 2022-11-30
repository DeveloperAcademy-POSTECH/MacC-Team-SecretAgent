//
//  AfterTimerDetailViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

import SnapKit
class AfterTimerDetailViewController: BaseViewController {

    // MARK: - Properties

    private let dismissButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 36, weight: .bold)), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let mainLabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        return label
    }()

    private let subLabel = {
        let label = UILabel()
        label.font = .regularBody
        label.numberOfLines = 0
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

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 16
        return button
    }()

    private let timerResult: TimerResult

    // MARK: - Init

    init(timerResult: TimerResult ) {
        self.timerResult = timerResult
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addAction()
    }

    override func render() {
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.top.equalToSuperview().offset(74)
            make.trailing.equalToSuperview().inset(29)
        }

        labelVStackView.addArrangedSubview(mainLabel)
        labelVStackView.addArrangedSubview(subLabel)
        view.addSubview(labelVStackView)

        labelVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(71)
            make.top.equalTo(dismissButton.snp.bottom).offset(41)
        }

        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(84)
            make.height.equalTo(61)
        }

    }

    override func configUI() {
        super.configUI()
        mainLabel.text = timerResult.mainLabel
        subLabel.text = timerResult.subLabel

    }

    // MARK: - Func

    private func addAction() {
        let dismissAction = UIAction { _ in
            self.dismiss(animated: true)
        }
        dismissButton.addAction(dismissAction, for: .touchUpInside)
    }
}

