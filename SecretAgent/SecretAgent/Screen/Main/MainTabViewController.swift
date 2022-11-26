//
//  ViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/17.
//

import UIKit

import SnapKit

class MainTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
    }

    func configUI() {
        setNavigationControllers()
        tabBar.tintColor = .systemYellow
        view.backgroundColor = .systemBackground
    }

    private func setNavigationControllers() {
        let boardNavigation = configureNavigationController(
            of: UIViewController(),
            title: TabBarLiteral.board(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.board(),
                image: ImageLiteral.inactiveBoardTab,
                selectedImage: ImageLiteral.boardTab
            )
        )
        let sirenNavigation = configureNavigationController(
            of: TestSirenViewController(),
            title: TabBarLiteral.siren(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.siren(),
                image: ImageLiteral.inactiveSirenTab,
                selectedImage: ImageLiteral.sirenTab
            )
        )
        let storyNavigation = configureNavigationController(
            of: UIViewController(),
            title: TabBarLiteral.story(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.story(),
                image: ImageLiteral.inactiveStoryTab,
                selectedImage: ImageLiteral.storyTab
            )
        )
        setViewControllers(
            [boardNavigation, sirenNavigation, storyNavigation],
            animated: true
        )
    }

    private func configureNavigationController(of viewController: UIViewController,
                                               title: String,
                                               tabBarItem: UITabBarItem) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)

        viewController.navigationItem.title = title

        // 오늘의 뱃지
        let todayBadgeButton = TodayBadge()

        todayBadgeButton.snp.makeConstraints { make in
            make.width.equalTo(Size.buttonWidth)
        }

        let horizontalStackView = UIStackView(arrangedSubviews: [todayBadgeButton])

        if title == TabBarLiteral.story() {
            let agentCardImageView = UIImageView(image: ImageLiteral.agent)
            let agentCardLabel = UILabel()

            agentCardLabel.text = NavigationBarLiteral.agentCard()
            agentCardLabel.font = .regularCaption2
            agentCardLabel.textAlignment = .center

            let agentCard = UIStackView(arrangedSubviews: [agentCardImageView, agentCardLabel])

            agentCard.axis = .vertical
            agentCard.distribution = .equalSpacing
            horizontalStackView.insertArrangedSubview(agentCard, at: 0)
        }

        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = Size.buttonSpacing
        horizontalStackView.distribution = .equalSpacing
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem = tabBarItem
        navigationController.navigationBar.layoutMargins.left = Size.navigationTitleLeading
        navigationController.view.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            // TODO: - SE 대응
            make.top.equalTo(navigationController.view.safeAreaLayoutGuide.snp.top).offset(Size.navigationBarHeight)
            make.height.equalTo(Size.buttonHeight)
            make.trailing.equalToSuperview().inset(Size.buttonTrailing)
        }

        if title == TabBarLiteral.board() {
            let navigationBarBackground = UIView()
            navigationBarBackground.backgroundColor = .yoGreen

            navigationBarBackground.layer.zPosition = -1

            navigationController.view.addSubview(navigationBarBackground)

            navigationBarBackground.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.bottom.equalTo(todayBadgeButton)
            }
            navigationController.navigationBar.tintColor = .white
            navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }

        return navigationController
    }
}

private enum TabBarLiteral: String {
    case board = "보드"
    case siren = "사이렌"
    case story = "스토리"

    func callAsFunction() -> String {
        return rawValue
    }
}

private enum NavigationBarLiteral: String {
    case todayBadges = "획득예정"
    case agentCard = "요원증"

    func callAsFunction() -> String {
        return rawValue
    }
}

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

private final class TodayBadge: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configChildViews()
        axis = .vertical
        distribution = .equalSpacing
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configChildViews() {
        // 좌상단
        let coinImageView: UIImageView = {
            let image = ImageLiteral.strokedCoin
            let imageView = UIImageView(image: image)

            return imageView
        }()

        coinImageView.snp.makeConstraints { make in
            make.width.equalTo(Size.coinWidth)
            make.height.equalTo(Size.coinHeight)
        }

        // 우상단
        let numberLabel: UILabel = {
            let label = UILabel()

            label.text = "5"
            label.font = .boldBody

            return label
        }()

        // 상단
        let coinAndNumber: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [coinImageView, numberLabel])

            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing

            return stackView
        }()

        // 하단
        let textLabel: UILabel = {
            let label = UILabel()

            label.text = NavigationBarLiteral.todayBadges()
            label.font = .regularCaption2
            label.textAlignment = .center

            return label
        }()
        addArrangedSubview(coinAndNumber)
        addArrangedSubview(textLabel)
    }
}

// MARK: - Previews

#if DEBUG
    import SwiftUI

    struct MainTabPreview: PreviewProvider {
        static var previews: some View {
            MainTabViewController().toPreview()
//            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
//            .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
        }
    }
#endif
