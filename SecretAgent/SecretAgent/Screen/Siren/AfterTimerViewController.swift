//
//  AfterTimerViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

import SnapKit

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
            return "웅웅외계인은 허탈하게 \n포기하고 돌아갔다,,,"
        case .fail:
            return "웅웅외계인이 폭식을 하고 돌아갔다..\n다음에 또 기지로 찾아오면 위험할거야!"
        }
    }

    var image: UIImage {
        switch self {
        case .success:
            return ImageLiteral.timerSuccess
        case .fail:
            return ImageLiteral.timerFail
        }
    }
}

private enum Size {
    static let labelVStackViewTopOffset = UIScreen.main.bounds.height / 5.86
    static let imageTopOffset = UIScreen.main.bounds.height / 30.14
    static let imageWidth = UIScreen.main.bounds.width / 1.30
    static let imageHeight = UIScreen.main.bounds.height / 2.81
    static let buttonVStackViewBottomOffset = UIScreen.main.bounds.height / 8.70
    static let defaultOffset = 20
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
        label.text = "꼬마요원이 15분동안 \n조용히 기지를 잘 지켰나요?"
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

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageLiteral.timerTimeOut
        return imageView
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
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
            make.top.equalToSuperview().offset(Size.labelVStackViewTopOffset)
        }
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(labelVStackView.snp.bottom).offset(Size.imageTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Size.defaultOffset)
            make.width.equalTo(Size.imageWidth)
            make.height.equalTo(Size.imageHeight)
        }

        buttonVStackView.addArrangedSubview(successButton)
        buttonVStackView.addArrangedSubview(failButton)
        view.addSubview(buttonVStackView)

        buttonVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
            make.bottom.equalToSuperview().inset(Size.buttonVStackViewBottomOffset)
        }
    }

    override func configUI() {
        super.configUI()
    }

    // MARK: - Func

    private func addAction() {
        let successAction = UIAction { _ in
            let afterTimerDetailVC = AfterTimerDetailViewController(timerResult: .success)
            afterTimerDetailVC.modalPresentationStyle = .fullScreen
            afterTimerDetailVC.modalTransitionStyle = .coverVertical
            self.present(afterTimerDetailVC, animated: true)
        }
        let failAction = UIAction { _ in
            let afterTimerDetailVC = AfterTimerDetailViewController(timerResult: .fail)
            afterTimerDetailVC.modalPresentationStyle = .fullScreen
            afterTimerDetailVC.modalTransitionStyle = .coverVertical
            self.present(afterTimerDetailVC, animated: true)
        }

        successButton.addAction(successAction, for: .touchUpInside)
        failButton.addAction(failAction, for: .touchUpInside)
    }
}
