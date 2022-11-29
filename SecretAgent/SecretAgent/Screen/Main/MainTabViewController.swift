//
//  ViewController.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/17.
//

import UIKit

import SnapKit

// MARK: - Literal

private enum TabBarLiteral: String {
    case board = "보드"
    case siren = "사이렌"
    case story = "스토리"

    func callAsFunction() -> String {
        return rawValue
    }
}

class MainTabViewController: UITabBarController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configUI()
        render()
    }

    func configUI() {
        setTabViewControllers()
        tabBar.tintColor = .systemYellow
        view.backgroundColor = .systemBackground
    }

    func render() {}

    // MARK: - Func

    private func setTabViewControllers() {
        let boardTab = BaseNavigationController(
            rootViewController: BaseViewController(),
            title: TabBarLiteral.board(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.board(),
                image: ImageLiteral.inactiveBoardTab,
                selectedImage: ImageLiteral.boardTab
            )
        )
        let sirenTab = BaseNavigationController(
            rootViewController: TestSirenViewController(),
            title: TabBarLiteral.siren(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.siren(),
                image: ImageLiteral.inactiveSirenTab,
                selectedImage: ImageLiteral.sirenTab
            )
        )
        let storyTab = BaseNavigationController(
            rootViewController: BaseViewController(),
            title: TabBarLiteral.story(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.story(),
                image: ImageLiteral.inactiveStoryTab,
                selectedImage: ImageLiteral.storyTab
            )
        )

        boardTab.setNavigationBarColor(to: .yoGreen)
        storyTab.appendAgentCard()

        setViewControllers(
            [boardTab, sirenTab, storyTab],
            animated: true
        )
    }
}
