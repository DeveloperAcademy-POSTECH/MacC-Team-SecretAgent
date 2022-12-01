//
//  AfterTimerDetailViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/28.
//

import UIKit

import SnapKit

private enum Size {
    static let defaultOffset = 20
    static let dismissButtonSize = 36
    static let dismissButtonTopOffset = UIScreen.main.bounds.height / 11.40
    static let dismissButtonTrailingOffset = UIScreen.main.bounds.width / 13.44

    static let imageTopOffset = UIScreen.main.bounds.height / 14.06
    static let imageWidth = UIScreen.main.bounds.width / 1.30
    static let imageHeight = UIScreen.main.bounds.height / 2.81
    static let confirmButtonBottomOffset = UIScreen.main.bounds.height / 8.70
    static let labelVStackViewTopOffset = UIScreen.main.bounds.height / 20.58
}

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

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = timerResult.image
        return imageView
    }()

    private let confirmButton: BaseButton = {
        let button = BaseButton()
        button.setButton(text: "확인", color: .black)
        button.setButtonTextColor(color: .white)
        button.makeButtonLarge()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return button
    }()

    private let timerResult: TimerResult

    // MARK: - Init

    init(timerResult: TimerResult) {
        self.timerResult = timerResult
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
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
            make.size.equalTo(Size.dismissButtonSize)
            make.top.equalToSuperview().offset(Size.dismissButtonTopOffset)
            make.trailing.equalToSuperview().inset(Size.dismissButtonTrailingOffset)
        }

        labelVStackView.addArrangedSubview(mainLabel)
        labelVStackView.addArrangedSubview(subLabel)
        view.addSubview(labelVStackView)

        labelVStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
            make.top.equalTo(dismissButton.snp.bottom).offset(Size.labelVStackViewTopOffset)
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Size.defaultOffset)
            make.top.equalTo(labelVStackView.snp.bottom).offset(Size.imageTopOffset)
            make.width.equalTo(Size.imageWidth)
            make.width.equalTo(Size.imageHeight)
        }

        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Size.defaultOffset)
            make.bottom.equalToSuperview().inset(Size.confirmButtonBottomOffset)
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
        let confirmAction = UIAction { _ in
            if self.timerResult == .fail {
                do {
                    try BadgeManager.shared.decreaseTodaysBadge()
                } catch {
                    print("오늘뱃지를 감소시키는 작업이 실패하였습니다.")
                }
            }
            guard let mainTabBarVC = self.presentingViewController?.presentingViewController as? UITabBarController else { return }
            mainTabBarVC.dismiss(animated: true) // 의문
        }
        dismissButton.addAction(dismissAction, for: .touchUpInside)
        confirmButton.addAction(confirmAction, for: .touchUpInside)
    }
}
