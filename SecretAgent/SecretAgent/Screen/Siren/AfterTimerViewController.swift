//
//  AfterTimerViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

enum TimerResult {
    case success
    case fail

    var mainLabel: String {
        switch self {
        case .success:
            return "임무 수행 성공!"
        case .fail:
            return "임무 수행 실패.."
        }
    }
    var subLabel: String {
        switch self {
        case .success:
            return "웅웅외계인은 허탈하게 포기하고 돌아갔다,,,"
        case .fail:
            return "앗 아앗..다행히 기지가 노출되진 않았지만 다시 찾아올 것 같다.."

        }
    }
}

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

    private let successButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "성공! (일일획득코인 유지)", color: .yoGreen)
        button.setButtonTextColor(color: .white)
        button.makeButtonLarge()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return button
    }()

    private let failButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "실패! (일일획득코인 1 차감)", color: .white)
        button.setButtonTextColor(color: .orange)
        button.setButtonBorder(color: UIColor.yoOrange.cgColor)
        button.makeButtonLarge()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
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
        addAction()
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
        buttonVStackView.addArrangedSubview(failButton)
        view.addSubview(buttonVStackView)

        buttonVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(84)
        }
    }

    override func configUI() {
        super.configUI()
    }

    // MARK: - Func

    private func addAction() {

        let successAction = UIAction { _ in
            let afterTimerVC = AfterTimerDetailViewController(timerResult: .success)
            afterTimerVC.modalPresentationStyle = .fullScreen
            afterTimerVC.modalTransitionStyle = .crossDissolve
            self.present(afterTimerVC, animated: true)
        }
        let failAction = UIAction { _ in
            let afterTimerVC = AfterTimerDetailViewController(timerResult: .fail)
            afterTimerVC.modalPresentationStyle = .fullScreen
            afterTimerVC.modalTransitionStyle = .crossDissolve
            self.present(afterTimerVC, animated: true)
        }

        successButton.addAction(successAction, for: .touchUpInside)
        failButton.addAction(failAction, for: .touchUpInside)

    }

}
