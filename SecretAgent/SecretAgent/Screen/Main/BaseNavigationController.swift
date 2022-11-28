//
//  BaseNavigationController.swift
//  SecretAgent
//
//  Created by taekkim on 2022/11/28.
//

import UIKit

// MARK: - Size

private enum Size {
    static let coinWidth = 28.0
    static let coinHeight = 30.0
    static let navigationTitleLeading = 30.0
    static let buttonTrailing = 30.0
    static let buttonWidth = 49.0
    static let buttonHeight = 52.0
    static let buttonSpacing = 36.0
    static let navigationBarHeight = 44.0
}

final class BaseNavigationController: UINavigationController {
    // MARK: - Properties

    private var todayBadge: TodayBadgeView!
    private var agentCard: AgentCardView!
    private var navigationButtons: UIStackView!
    private var navigationBarHeader: UIView!
    private var navigationBarFooter: UIView!

    // MARK: - Life Cycle

    init(rootViewController: UIViewController, title: String, tabBarItem: UITabBarItem) {
        rootViewController.navigationItem.title = title
        super.init(rootViewController: rootViewController)
        self.tabBarItem = tabBarItem
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }

    private func configUI() {
        setNavigationButtons()
        navigationBar.prefersLargeTitles = true
        navigationBar.layoutMargins.left = Size.navigationTitleLeading
    }

    private func render() {
        todayBadge.snp.makeConstraints { make in
            make.width.equalTo(Size.buttonWidth)
        }

        view.addSubview(navigationButtons)

        navigationButtons.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Size.navigationBarHeight)
            make.height.equalTo(Size.buttonHeight)
            make.trailing.equalToSuperview().inset(Size.buttonTrailing)
        }
    }

    // MARK: - Func

    private func setNavigationButtons() {
        todayBadge = TodayBadgeView()

        navigationButtons = UIStackView(arrangedSubviews: [todayBadge])
        navigationButtons.axis = .horizontal
        navigationButtons.spacing = Size.buttonSpacing
        navigationButtons.distribution = .equalSpacing
    }

    private func setNavigationBarBackground(to color: UIColor) {
        navigationBarHeader = UIView()
        navigationBarHeader.backgroundColor = color
        navigationBar.addSubview(navigationBarHeader)

        navigationBar.backgroundColor = color

        navigationBarFooter = UIView()
        navigationBarFooter.backgroundColor = color
        navigationBar.addSubview(navigationBarFooter)
    }

    private func setNavigationBarLayout() {
        navigationBarHeader.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        navigationBarFooter.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(todayBadge.snp.bottom).offset(10)
        }
    }

    func setNavigationBarColor(to color: UIColor) {
        setNavigationBarBackground(to: color)
        setNavigationBarLayout()

        navigationBar.tintColor = .white
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        todayBadge.setChildLabelColor(to: .white)
    }

    func appendAgentCard() {
        agentCard = AgentCardView()
        navigationButtons.insertArrangedSubview(agentCard, at: 0)
    }
}

private extension UIStackView {
    func setChildLabelColor(to color: UIColor) {
        arrangedSubviews.forEach { subView in
            if let subLabel = subView as? UILabel {
                subLabel.textColor = .white
            } else if let subStackView = subView as? UIStackView {
                subStackView.setChildLabelColor(to: color)
            }
        }
    }
}
