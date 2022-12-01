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
    private var todayCoin: Int = 5 {
        didSet {
            boardTab.updateTodayCoin(to: self.todayCoin)
            sirenTab.updateTodayCoin(to: self.todayCoin)
            storyTab.updateTodayCoin(to: self.todayCoin)
        }
    }
    private var boardTab: BaseNavigationController!
    private var sirenTab: BaseNavigationController!
    private var storyTab: BaseNavigationController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
        render()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let (todayCoin, error) = try? BadgeManager.shared.coinsLeftForToday() else { return }

        guard error == 1 else { return }

        if self.todayCoin != todayCoin {
            self.todayCoin = todayCoin
        }
    }

    func configUI() {
        setTabViewControllers()
        tabBar.tintColor = .systemYellow
        tabBar.backgroundColor = .white
        view.backgroundColor = .systemBackground
    }

    func render() {}

    // MARK: - Func

    private func setTabViewControllers() {
        boardTab = BaseNavigationController(
            rootViewController: BoardViewController(),
            title: TabBarLiteral.board(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.board(),
                image: ImageLiteral.inactiveBoardTab,
                selectedImage: ImageLiteral.boardTab
            )
        )
        sirenTab = BaseNavigationController(
            rootViewController: SirenViewController(),
            title: TabBarLiteral.siren(),
            tabBarItem: UITabBarItem(
                title: TabBarLiteral.siren(),
                image: ImageLiteral.inactiveSirenTab,
                selectedImage: ImageLiteral.sirenTab
            )
        )
        storyTab = BaseNavigationController(
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
