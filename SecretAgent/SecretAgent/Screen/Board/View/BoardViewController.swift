//
//  BoardViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

import SnapKit

enum BoardSize {
    static let collectionViewInsets: UIEdgeInsets = .init(top: 52, left: 0, bottom: 52, right: 0)
    static let collectionViewLineSpacing: Double = 25.85
    static let upperBadgeInfoHeight: Double = 56
    static let tableViewRowHeight: Double = 50
    static let tableViewRowWidth: Double = 193
    static let safeAreaTopInset = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    static let coinSize = CGSize(width: 90, height: 96.15)
    static let shieldSize = CGSize(width: 96, height: 135.17)
    static let starSize = CGSize(width: 163.0, height: 196.0)
}

final class BoardViewController: BaseViewController {
    // MARK: - Properties

    var totalBadgeNumber: Int = 0
    var totalBadgeNumberFromCoreData: Int = 0
    var curTableViewIndexPath = IndexPath(row: 0, section: 0)
    let tableViewDataSource = ["포요스타", "비요스타", "키요스타", "마요스타", "모두스타"]
    let starBadgeTypes: [BadgeType] = [.poyoStar, .biyoStar, .kiyoStar, .mayoStar, .allStar]

    // MARK: - UI Properties

    private lazy var tempButton: UIButton = {
        let button = UIButton()
        button.setTitle("테스트", for: .normal)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(showCongratsModal), for: .touchUpInside)
        return button
    }()

    private lazy var dropdownBackgroundView: UIView = {
        let testView = UIView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeDropdownBackgroundView))
        testView.addGestureRecognizer(tapGesture)
        return testView
    }()

    private let dropdownTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = BoardSize.tableViewRowHeight
        tableView.layer.cornerRadius = 5
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()

    lazy var dropdownButton: UIButton = {
        let button = UIButton()
        button.setTitle("포요스타 ▼", for: .normal)
        button.titleLabel?.font = UIFont.oneMobile(size: 12)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()

    private lazy var fixedBadgeInformation: UIStackView = {
        let stackView = UIStackView()

        let coinBadge = CommonBadgeInfoComponent(image: ImageLiteral.coin)
        let shieldBadge = CommonBadgeInfoComponent(image: ImageLiteral.shield)
        let starBadge = CommonBadgeInfoComponent(image: ImageLiteral.star)

        [dropdownButton, coinBadge, shieldBadge, starBadge].forEach { subView in
            stackView.addArrangedSubview(subView)
            subView.backgroundColor = .white
            subView.frame.size = .init(width: 80, height: 10)
            subView.layer.cornerRadius = 36 / 2
            subView.snp.makeConstraints { make in
                make.height.equalTo(36)
            }
        }

        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = UIColor.yoGray2
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    private lazy var badgeCollectionFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = BoardSize.collectionViewLineSpacing
        layout.sectionInset = BoardSize.collectionViewInsets
        return layout
    }()

    lazy var badgeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: badgeCollectionFlowLayout)
        collectionView.register(cell: BadgeCollectionViewCell.self)
        return collectionView
    }()

    private let hideBadgeView = HideBadgeView()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTotalBadgeFromCoreData()
        setDelegation()
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollCollectionView()
    }

    override func render() {
        view.addSubview(fixedBadgeInformation)
        fixedBadgeInformation.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(BoardSize.upperBadgeInfoHeight)
        }

        view.addSubview(badgeCollectionView)
        badgeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(fixedBadgeInformation.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        view.addSubview(hideBadgeView)
        hideBadgeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(BoardSize.upperBadgeInfoHeight)
        }

        view.addSubview(dropdownBackgroundView)
        view.addSubview(dropdownTableView)

        view.addSubview(tempButton)
        tempButton.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.bottom.trailing.equalToSuperview()
        }
    }

    override func configUI() {
        view.backgroundColor = .systemBackground
        hideBadgeView.alpha = 0.0
    }

    // MARK: - Func

    private func setDelegation() {
        badgeCollectionView.delegate = self
        badgeCollectionView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
    }

    @objc func showDropdown(_ sender: UIButton) {
        addDropdownBackgroundView(buttonFrame: sender.frame)
    }

    private func addDropdownBackgroundView(buttonFrame: CGRect) {
        dropdownBackgroundView.frame = view.frame
        dropdownTableView.frame = CGRect(
            x: buttonFrame.origin.x + 5,
            y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset,
            width: BoardSize.tableViewRowWidth,
            height: 0
        )

        dropdownTableView.reloadData()

        dropdownBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        dropdownBackgroundView.alpha = 0

        animate { [weak self] in
            self?.dropdownBackgroundView.alpha = 0.5
            self?.dropdownTableView.frame = CGRect(
                x: buttonFrame.origin.x + 5,
                y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset + Double(5),
                width: BoardSize.tableViewRowWidth,
                height: Double(self?.tableViewDataSource.count ?? 0) * BoardSize.tableViewRowHeight
            )
        }
    }

    @objc func removeDropdownBackgroundView() {
        let buttonFrame = dropdownButton.frame
        animate { [weak self] in
            self?.dropdownBackgroundView.alpha = 0
            self?.dropdownTableView.frame = CGRect(
                x: buttonFrame.origin.x + 5,
                y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset,
                width: BoardSize.tableViewRowWidth,
                height: 0
            )
        }
    }

    func addHideBadgeView(previous: String?) {
        hideBadgeView.isHidden = false
        hideBadgeView.infoLabel.text = "\(previous ?? "이전 스타")를 획득해야\n시작할 수 있어요!"

        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.hideBadgeView.alpha = 1
            }
        )
    }

    func removeHideBadgeView() {
        hideBadgeView.isHidden = true
        hideBadgeView.alpha = 0
    }

    private func animate(of animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: animations)
    }

    private func updateBadgeInformation() {
        let coin = fixedBadgeInformation.arrangedSubviews[1]
        let coinLabel = coin.subviews.first as? UILabel
        coinLabel?.text = "\(min(totalBadgeNumber, 125))"
        let shield = fixedBadgeInformation.arrangedSubviews[2]
        let shieldLabel = shield.subviews.first as? UILabel
        shieldLabel?.text = "\(totalBadgeNumber / 5)"
        let star = fixedBadgeInformation.arrangedSubviews[3]
        let starLabel = star.subviews.first as? UILabel
        starLabel?.text = "\(totalBadgeNumber / 25)"
    }

    private func updateTotalBadgeFromCoreData() {
        do {
            try BadgeManager.shared.updateTotalBadge()
            do {
                let getBadgeNumberFromCoreData = try BadgeManager.shared.numberOfTotalCoins()
                totalBadgeNumber = getBadgeNumberFromCoreData.result
                totalBadgeNumberFromCoreData = getBadgeNumberFromCoreData.result
                updateBadgeInformation()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func scrollCollectionView() {
        let badgeNumberWhenFull = (curTableViewIndexPath.row + 1) * 25
        let badgeNumberWhenEmpty = badgeNumberWhenFull - 25

        if badgeNumberWhenFull <= totalBadgeNumberFromCoreData {
            badgeCollectionView.scrollToItem(at: IndexPath(row: 30, section: 0), at: .top, animated: true)
        } else if badgeNumberWhenEmpty >= totalBadgeNumberFromCoreData {
            badgeCollectionView.scrollToItem(at: IndexPath(row: -1, section: 0), at: .top, animated: true)
        } else {
            let badgeNumber = totalBadgeNumberFromCoreData - badgeNumberWhenEmpty
            let shieldNumber = badgeNumber / 5
            badgeCollectionView.scrollToItem(at: IndexPath(row: badgeNumber + shieldNumber, section: 0), at: .centeredVertically, animated: true)
        }
    }

    @objc private func showCongratsModal() {
        let congratsModal = StarCollectCongratsViewController()
        congratsModal.modalPresentationStyle = .fullScreen
        congratsModal.badgeType = starBadgeTypes[curTableViewIndexPath.row]
        navigationController?.present(congratsModal, animated: true)
    }
}
