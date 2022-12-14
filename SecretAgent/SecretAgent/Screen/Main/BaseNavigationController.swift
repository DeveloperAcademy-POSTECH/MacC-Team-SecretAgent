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
    static let buttonWidth = 39.0
    static let buttonHeight = 41.0
    static let buttonSpacing = 36.0
    static let navigationBarHeight = 44.0
    static let navigationHeight = 96.0
    static let agentCardWidth = 28.0
    static let coinPromptHeight = 247
}

final class BaseNavigationController: UINavigationController {
    // MARK: - Properties

    private var numberOfCoins = 5
    private var todayBadge: TodayBadgeView!
    private var agentCard: AgentCardThumbnailView!
    var navigationButtons: UIStackView!
    private var navigationBarHeader: UIView!
    private var navigationBarFooter: UIView!
    private lazy var todayCoinModal: TodayCoinModal = {
        let modal = TodayCoinModal(of: numberOfCoins)
        modal.isHidden = true
        return modal
    }()

    private lazy var disableView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .yoBlack
        uiView.alpha = 0.5
        uiView.isHidden = true
        return uiView
    }()

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
        setNavigationButtons()
        render()
        configUI()
        hideModalTappedAround()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont
            .oneMobile(textStyle: .body)]
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lazyRender()
    }

    private func render() {
        todayBadge.snp.makeConstraints { make in
            make.width.equalTo(Size.buttonWidth)
        }

        navigationBar.addSubview(navigationButtons)
        navigationButtons.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.top).offset(Size.navigationBarHeight)
            make.height.equalTo(Size.buttonHeight)
            make.trailing.equalToSuperview().inset(Size.buttonTrailing)
        }
    }

    private func lazyRender() {
        tabBarController?.view.addSubview(todayCoinModal)
        todayCoinModal.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Size.navigationHeight)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(Size.coinPromptHeight)
        }

        tabBarController?.view.addSubview(disableView)
        disableView.snp.makeConstraints { make in
            make.top.equalTo(todayCoinModal.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    private func configUI() {
        navigationBar.prefersLargeTitles = true
        navigationBar.layoutMargins.left = Size.navigationTitleLeading
        navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.oneMobile(size: 30)]
    }

    // MARK: - Func

    private func setNavigationButtons() {
        todayBadge = TodayBadgeView()
        todayBadge.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleModal))
        todayBadge.addGestureRecognizer(gesture)

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

    func setCustomNavigationBarHidden() {}

    func setNavigationBarColor(to color: UIColor) {
        setNavigationBarBackground(to: color)
        setNavigationBarLayout()

        navigationBar.tintColor = .white
        navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.font: UIFont.oneMobile(size: 30),
             NSAttributedString.Key.foregroundColor: UIColor.white]
        todayBadge.setChildLabelColor(to: .white)
    }

    func appendAgentCard() {
        agentCard = AgentCardThumbnailView()
        agentCard.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentAgentCard))
        agentCard.addGestureRecognizer(gesture)
        agentCard.snp.makeConstraints { make in
            make.width.equalTo(Size.agentCardWidth)
        }
        navigationButtons.insertArrangedSubview(agentCard, at: 0)
    }

    @objc func presentAgentCard() {
        let agentCardViewController = AgentCardViewController()
        agentCardViewController.modalPresentationStyle = .fullScreen
        present(agentCardViewController, animated: true)
    }

    private func hideModalTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleModal))
        disableView.addGestureRecognizer(tap)
    }

    @objc func toggleModal() {
        animate { [weak self] in
            self?.todayCoinModal.isHidden.toggle()
            self?.disableView.isHidden.toggle()
        }
    }

    private func animate(of animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: animations)
    }

    func updateTodayCoin(to number: Int) {
        numberOfCoins = number
        todayBadge.updateNumberOfCoins(to: number)
        todayCoinModal.updateCoins(to: number)
        loadViewIfNeeded()
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
