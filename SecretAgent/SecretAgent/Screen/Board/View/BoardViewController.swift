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
}

final class BoardViewController: BaseViewController {
    // TODO: - 아래의 목데이터를 CoreData로 교체
    let totalBadgeNumber = 15
    let coinBadgeNumber = 5
    let shieldBadgeNumber = 1
    let starBadgeNumber = 0

    // MARK: - Properties

    private lazy var dropdownBackgroundView: UIView = {
        let testView = UIView()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeDropdownBackgroundView))
        testView.addGestureRecognizer(tapgesture)
        return testView
    }()

    private let dropdownTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = BoardSize.tableViewRowHeight
        tableView.layer.cornerRadius = 5
        tableView.separatorInset = UIEdgeInsets.zero
        return tableView
    }()

    private let tableViewDataSource = ["1스타", "2스타", "3스타", "4스타", "5스타"]

    private lazy var dropdownButton: UIButton = {
        let button = UIButton()
        button.setTitle("1스타", for: .normal)
        button.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        return button
    }()

    private lazy var fixedBadgeInformation: UIStackView = {
        let stackView = UIStackView()

        // MARK: - 아래의 코드는 모두 임시 코드입니다.

        let coinBadge = UILabel()
        coinBadge.text = "코인뱃지: \(coinBadgeNumber)"
        coinBadge.textAlignment = .center
        let shieldBadge = UILabel()
        shieldBadge.text = "방패뱃지: \(shieldBadgeNumber)"
        shieldBadge.textAlignment = .center
        let starBadge = UILabel()
        starBadge.text = "스타뱃지: \(starBadgeNumber)"
        starBadge.textAlignment = .center
        [dropdownButton, coinBadge, shieldBadge, starBadge].forEach { subView in
            stackView.addArrangedSubview(subView)
            subView.backgroundColor = [.blue, .yellow, .orange, .red, .purple, .green, .systemTeal, .systemPink].randomElement()
        }

        // MARK: - 위의 코드는 모두 임시 코드입니다.

        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = .gray
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
        collectionView.register(cell: BadgeCollectionViewCell.self, forCellReuseIdentifier: BadgeCollectionViewCell.identifier)
        return collectionView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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

        view.addSubview(dropdownBackgroundView)
        view.addSubview(dropdownTableView)
    }

    override func configUI() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Func

    @objc func showDropdown(_ sender: UIButton) {
        addDropdownBackgroundView(buttonFrame: sender.frame)
    }

    private func setDelegation() {
        badgeCollectionView.delegate = self
        badgeCollectionView.dataSource = self
        dropdownTableView.delegate = self
        dropdownTableView.dataSource = self
    }

    func addDropdownBackgroundView(buttonFrame: CGRect) {
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

        UIView.animate(
            withDuration: 0.4,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseInOut,
            animations: {
                self.dropdownBackgroundView.alpha = 0.5
                self.dropdownTableView.frame = CGRect(x: buttonFrame.origin.x + 5,
                                                      y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset + Double(5),
                                                      width: BoardSize.tableViewRowWidth,
                                                      height: Double(self.tableViewDataSource.count) * BoardSize.tableViewRowHeight)
            }, completion: nil
        )
    }

    @objc func removeDropdownBackgroundView() {
        let buttonFrame = dropdownButton.frame
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.dropdownBackgroundView.alpha = 0
            self.dropdownTableView.frame = CGRect(x: buttonFrame.origin.x + 5,
                                                  y: buttonFrame.origin.y + buttonFrame.height + BoardSize.safeAreaTopInset,
                                                  width: BoardSize.tableViewRowWidth,
                                                  height: 0)
        }, completion: nil)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath) as? BadgeCollectionViewCell

        let badgeIndex = indexPath.row

        if (badgeIndex + 1) % 6 == 0 {
            // 방패 뱃지
            myCell?.badgeType = .shield

        } else {
            // 코인 뱃지
            myCell?.badgeType = .coin
        }

        // 스타 뱃지
        if badgeIndex == 30 {
            myCell?.badgeType = .star
        }

        // 이미지 생성
        if badgeIndex < totalBadgeNumber {
            myCell?.generateActiveImage()
        } else {
            myCell?.generateInactiveImage()
        }

        switch badgeIndex % 4 {
        case 0:
            myCell?.frame.size.width = Double(myCell?.getBadgeWidth() ?? 0) + 50 // 뱃지크기 + 여백
        case 1, 3:
            myCell?.frame.size.width = Double(view.frame.size.width / 2) + ((myCell?.getBadgeWidth() ?? 0) / 2) // 반 채우고 뱃지 크기 반 만큼
        case 2:
            myCell?.frame.size.width = view.frame.size.width - 50 // 전체 너비 - 여백
        default:
            myCell?.frame.size.width = .zero
        }

        if badgeIndex == 30 {
            myCell?.frame.size.width = Double(view.frame.size.width / 2) + ((myCell?.getBadgeWidth() ?? 0) / 2)
        }

        myCell?.setImageFrame()

        return myCell ?? collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath)
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
        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.textLabel?.textAlignment = .center
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dropdownButton.setTitle(tableViewDataSource[indexPath.row], for: .normal)
        removeDropdownBackgroundView()
    }
}
