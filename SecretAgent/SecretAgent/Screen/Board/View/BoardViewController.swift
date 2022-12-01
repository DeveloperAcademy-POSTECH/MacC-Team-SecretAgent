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
    static let mentSize = CGSize(width: 170, height: 87)
}

final class BoardViewController: BaseViewController {
    // MARK: - Properties

    // 뱃지 관련
    var totalBadgeNumber: Int = 0
    var totalBadgeNumberFromCoreData: Int = 0
    var allStarsCollected = false

    // 테이블 뷰 관련
    var curTableViewIndexPath = IndexPath(row: 0, section: 0)
    let tableViewDataSource = ["포요스타", "키요스타", "비요스타", "마요스타", "모두스타"]
    let starBadgeTypes: [BadgeType] = [.poyoStar, .kiyoStar, .biyoStar, .mayoStar, .allStar]

    // MARK: - UI Properties

    // 테스트 용 UI
    private lazy var testIncreaseBadge: UIButton = {
        let button = UIButton()
        button.setTitle("뱃지늘리고 실제로 받는 버튼", for: .normal)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(testIncreaseBadgeNumber), for: .touchUpInside)
        return button
    }()

    private lazy var testDecreaseBadge: UIButton = {
        let button = UIButton()
        button.setTitle("뱃지줄이는버튼", for: .normal)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(testDecreaseBadgeNumber), for: .touchUpInside)
        return button
    }()

    private lazy var testStackView: UIStackView = {
        let stackView = UIStackView()

        [testIncreaseBadge, testDecreaseBadge].forEach { subView in
            stackView.addArrangedSubview(subView)
            subView.backgroundColor = .systemTeal
            subView.frame.size = .init(width: 80, height: 10)
            subView.layer.cornerRadius = 36 / 2
            subView.snp.makeConstraints { make in
                make.height.equalTo(36)
            }
        }

        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.backgroundColor = .orange
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true

        return stackView
    }()

    // 드롭다운 관련
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

    // 상단에 고정되는 뱃지 정보
    private lazy var upperFixedBadgeInformation: UIStackView = {
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

    // 뱃지 지도
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

    // 스타 획득 축하 모달
    private let starCollectCongratsView = StarCollectCongratsViewController()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
    }

    override func viewDidAppear(_ animated: Bool) {
        updateTotalBadgeFromCoreData()
        if totalBadgeNumberFromCoreData >= 125 {
            allStarsCollected = true
        }
        refreshBoard(targetIndex: getLatestTableViewIndex())
    }

    override func render() {
        view.addSubview(upperFixedBadgeInformation)
        upperFixedBadgeInformation.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(BoardSize.upperBadgeInfoHeight)
        }

        view.addSubview(badgeCollectionView)
        badgeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(upperFixedBadgeInformation.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        view.addSubview(hideBadgeView)
        hideBadgeView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(BoardSize.upperBadgeInfoHeight)
        }

        view.addSubview(dropdownBackgroundView)
        view.addSubview(dropdownTableView)

        view.addSubview(testStackView)
        testStackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(80)
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
        starCollectCongratsView.delegate = self
    }

    // 드롭다운
    @objc func showDropdown(_ sender: UIButton) {
        addDropdownBackgroundView(buttonFrame: sender.frame)
    }

    private func addDropdownBackgroundView(buttonFrame: CGRect) {
        dropdownBackgroundView.frame = view.frame
        dropdownTableView.frame = CGRect(
            x: buttonFrame.origin.x + 5,
            // FIXME: - 여기서 Navigation Height을 적용해야 할 듯
            y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset + 100,
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
                y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset + Double(5) + 100,
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
                y: buttonFrame.origin.y + buttonFrame.height + Double(BoardSize.safeAreaTopInset) + 100,
                width: BoardSize.tableViewRowWidth,
                height: 0
            )
        }
    }

    // 이전 뱃지 획득 여부에 따른 뷰 전환
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

    // 화면에 뱃지 개수 업데이트
    private func updateBadgeInformation() {
        let coin = upperFixedBadgeInformation.arrangedSubviews[1]
        let coinLabel = coin.subviews.first as? UILabel
        coinLabel?.text = "\(min(totalBadgeNumber, 125))"
        let shield = upperFixedBadgeInformation.arrangedSubviews[2]
        let shieldLabel = shield.subviews.first as? UILabel
        shieldLabel?.text = "\(totalBadgeNumber / 5)"
        let star = upperFixedBadgeInformation.arrangedSubviews[3]
        let starLabel = star.subviews.first as? UILabel
        starLabel?.text = "\(totalBadgeNumber / 25)"
    }

    // CoreData에서 전체 뱃지 수 가져오기
    private func updateTotalBadgeFromCoreData() {
        do {
            let getBadgeNumberFromCoreData = try BadgeManager.shared.numberOfTotalCoins()
            totalBadgeNumber = getBadgeNumberFromCoreData.result
            totalBadgeNumberFromCoreData = getBadgeNumberFromCoreData.result
            updateBadgeInformation()
        } catch {
            print(error)
        }
    }

    // 가장 최근에 수집한 뱃지 위치로 이동
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

    // 스타 화면 보여주기
    @objc private func showCongratsModal(goToNewPage: Bool) {
        let congratsModal = starCollectCongratsView
        congratsModal.modalPresentationStyle = .fullScreen

        congratsModal.badgeType = starBadgeTypes[goToNewPage ? max(curTableViewIndexPath.row - 1, 0) : max(curTableViewIndexPath.row, 0)]
        navigationController?.present(congratsModal, animated: true)
    }

    // 특정 스타 뱃지 보드로 이동
    func refreshBoard(targetIndex: Int) {
        dropdownButton.setTitle("\(tableViewDataSource[min(targetIndex, 4)]) ▼", for: .normal)
        removeDropdownBackgroundView()

        curTableViewIndexPath = IndexPath(row: targetIndex, section: 0)

        let decreaseAmount = targetIndex * 25
        totalBadgeNumber = totalBadgeNumberFromCoreData - decreaseAmount

        if totalBadgeNumber < 0, targetIndex > 0 {
            addHideBadgeView(previous: targetIndex > 0 ? tableViewDataSource[targetIndex - 1] : nil)
        } else {
            removeHideBadgeView()
        }

        badgeCollectionView.reloadData()

        scrollCollectionView()
    }

    // 모았던 뱃지를 실제 CoreData에 저장하기
    func recieveTodaysBadges() {
        var previousTotalBadge = 0
        do {
            previousTotalBadge = try BadgeManager.shared.numberOfTotalCoins().result
        } catch {
            print("error")
        }

        var updatedTotalBadge = 0
        var todaysBadgeNumber = 0

        // 코어데이터에 반영하기
        do {
            try BadgeManager.shared.resetTodaysBadge()
            try BadgeManager.shared.updateTotalBadge()
            do {
                let getBadgeNumberFromCoreData = try BadgeManager.shared.numberOfTotalCoins()
                totalBadgeNumber = getBadgeNumberFromCoreData.result
                totalBadgeNumberFromCoreData = getBadgeNumberFromCoreData.result

                // 가장 최근 뱃지로 이동
                updateBadgeInformation()
                refreshBoard(targetIndex: min((totalBadgeNumberFromCoreData - 1) / 25, 4))

                todaysBadgeNumber = try BadgeManager.shared.coinsLeftForToday().result
                updatedTotalBadge = try BadgeManager.shared.numberOfTotalCoins().result
            } catch {
                print("error")
            }
        } catch {
            print(error)
        }

        var latestStarIndex = getLatestTableViewIndex()

        // TODO: - 인터랙션 보여주기
        showRecievedBadgesInteraction()

        // alert 띄우기, Star 뱃지면 모달 띄우기
        let justGotStarBadge = updatedTotalBadge % 25 == 0
        let gotStarBadgeAndMore = previousTotalBadge / 25 < latestStarIndex

        showBadgeCollectedAlert(todaysBadgeNumber: todaysBadgeNumber, didGetStarBadge: justGotStarBadge || gotStarBadgeAndMore)

        // TODO: - 임무 완료 메시지도 반영
    }

    func showBadgeCollectedAlert(todaysBadgeNumber: Int, didGetStarBadge: Bool) {
        makeAlert(title: "획득한 보상뱃지 총 \(todaysBadgeNumber)개", message: "어제 임무완수의 결과입니다.\n아이와 함께 결과를 보고\n결과에 맞는 칭찬과 응원을 해주세요.", okayAction: { _ in
            if didGetStarBadge {
                self.showCongratsModal(goToNewPage: todaysBadgeNumber % 25 != 0 && self.totalBadgeNumberFromCoreData < 125)
            }
        })
    }

    @objc func testIncreaseBadgeNumber() {
        recieveTodaysBadges()
    }

    @objc func testDecreaseBadgeNumber() {
        do {
            try BadgeManager.shared.testUpdateTotalBadge()
            do {
                let getBadgeNumberFromCoreData = try BadgeManager.shared.numberOfTotalCoins()
                totalBadgeNumber = getBadgeNumberFromCoreData.result
                totalBadgeNumberFromCoreData = getBadgeNumberFromCoreData.result
                updateBadgeInformation()
                refreshBoard(targetIndex: min(totalBadgeNumberFromCoreData / 25, 4))
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func showRecievedBadgesInteraction() {
        // TODO: - 아마 다음 스프린트에..? 인터랙션 넣기
        print("showRecievedBadgesInteraction")
    }

    func getLatestTableViewIndex() -> Int {
        return (totalBadgeNumberFromCoreData - 1) / 25
    }

    // 공통적으로 쓰이는 animate 함수
    private func animate(of animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: animations)
    }
}

// MARK: StarCollectCongratsViewDelegate

extension BoardViewController: StarCollectCongratsViewDelegate {
    func whatToDoAfterStarModal() {
        if totalBadgeNumberFromCoreData >= 125 {
            allStarsCollected = true
            badgeCollectionView.reloadData()
        }
    }
}
