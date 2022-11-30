//
//  BoardViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

import SnapKit

private enum BoardSize {
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

enum BadgeType {
    case coin
    case shield
    case star
    case poyoStar
    case biyoStar
    case kiyoStar
    case mayoStar
    case allStar

    var badgeActiveImage: UIImage {
        switch self {
        case .coin:
            return ImageLiteral.coin
        case .shield:
            return ImageLiteral.shield
        case .star:
            return ImageLiteral.star
        case .poyoStar:
            return ImageLiteral.poyoStar
        case .biyoStar:
            return ImageLiteral.biyoStar
        case .kiyoStar:
            return ImageLiteral.kiyoStar
        case .mayoStar:
            return ImageLiteral.mayoStar
        case .allStar:
            return ImageLiteral.allStar
        }
    }

    var badgeInactiveImage: UIImage {
        switch self {
        case .coin:
            return ImageLiteral.inactiveCoin
        case .shield:
            return ImageLiteral.inactiveShield
        case .star:
            return ImageLiteral.inactiveStar
        case .poyoStar:
            return ImageLiteral.inactivePoyoStar
        case .biyoStar:
            return ImageLiteral.inactiveBiyoStar
        case .kiyoStar:
            return ImageLiteral.inactiveKiyoStar
        case .mayoStar:
            return ImageLiteral.inactiveMayoStar
        case .allStar:
            return ImageLiteral.inactiveAllStar
        }
    }
}

final class BoardViewController: BaseViewController {
    // MARK: - Properties

    private var totalBadgeNumber: Int = 0
    private var totalBadgeNumberFromCoreData: Int = 0
    private var curIndexPath = IndexPath(row: 0, section: 0)
    private let tableViewDataSource = ["포요스타", "비요스타", "키요스타", "마요스타", "모두스타"]
    private let starBadgeTypes: [BadgeType] = [.poyoStar, .biyoStar, .kiyoStar, .mayoStar, .allStar]

    // MARK: - UI Properties

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

    private lazy var dropdownButton: UIButton = {
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

    private lazy var badgeCollectionView: UICollectionView = {
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

    private func addHideBadgeView(previous: String?) {
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

    private func removeHideBadgeView() {
        hideBadgeView.isHidden = true
        hideBadgeView.alpha = 0
    }

    private func animate(of animations: @escaping () -> Void) {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: animations)
    }

    private func updateBadgeInformation() {
        let coin = fixedBadgeInformation.arrangedSubviews[1]
        let coinLabel = coin.subviews.first as? UILabel
        coinLabel?.text = "\(totalBadgeNumber)"
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
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withType: BadgeCollectionViewCell.self, for: indexPath)

        let decreaseAmount = 25 * curIndexPath.row
        totalBadgeNumber = totalBadgeNumberFromCoreData - decreaseAmount

        let badgeIndex = indexPath.row
        let shieldNumber = Int(totalBadgeNumber / 5)

        // 뱃지 타입 할당
        if (badgeIndex + 1) % 6 == 0 {
            myCell.badgeType = .shield
        } else {
            myCell.badgeType = .coin
        }
        if badgeIndex == 30 {
            myCell.badgeType = starBadgeTypes[curIndexPath.row]
        }

        // 이미지 생성
        if badgeIndex < totalBadgeNumber + shieldNumber {
            myCell.generateActiveImage()
        } else {
            if badgeIndex % 5 == 0, (badgeIndex / 5) == shieldNumber, badgeIndex > 0 {
                myCell.generateActiveImage()
            } else {
                myCell.generateInactiveImage()
            }
        }

        if badgeIndex == 30, badgeIndex == totalBadgeNumber + shieldNumber {
            myCell.generateActiveImage()
        }

        switch badgeIndex % 4 {
        case 0:
            myCell.frame.size.width = Double(myCell.getBadgeWidth() + 50) // 뱃지크기 + 여백
        case 1, 3:
            myCell.frame.size.width = Double(view.frame.size.width / 2) + (myCell.getBadgeWidth() / 2) // 반 채우고 뱃지 크기 반 만큼
        case 2:
            myCell.frame.size.width = view.frame.size.width - 50 // 전체 너비 - 여백
        default:
            myCell.frame.size.width = .zero
        }

        if badgeIndex == 30 {
            myCell.frame.size.width = Double(view.frame.size.width / 2) + (myCell.getBadgeWidth() / 2)
        }

        myCell.setImageFrame()

        return myCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemHeight: Double = 0

        if (indexPath.row + 1) % 6 == 0 {
            itemHeight = BoardSize.shieldSize.height
        } else {
            itemHeight = BoardSize.coinSize.height
        }

        if indexPath.row == 30 {
            itemHeight = BoardSize.starSize.height
        }

        return CGSize(width: view.frame.size.width, height: itemHeight)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension BoardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(tableViewDataSource[indexPath.row])"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.boldBody
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropdownButton.setTitle("\(tableViewDataSource[indexPath.row]) ▼", for: .normal)
        removeDropdownBackgroundView()

        curIndexPath = indexPath

        let decreaseAmount = 25 * indexPath.row
        totalBadgeNumber = totalBadgeNumberFromCoreData - decreaseAmount

        if totalBadgeNumber <= 0, indexPath.row > 0 {
            addHideBadgeView(previous: indexPath.row > 0 ? tableViewDataSource[indexPath.row - 1] : nil)
        } else {
            removeHideBadgeView()
        }

        badgeCollectionView.reloadData()
    }
}
