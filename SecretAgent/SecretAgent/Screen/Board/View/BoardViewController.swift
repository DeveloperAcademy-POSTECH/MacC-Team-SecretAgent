//
//  BoardViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

private enum BoardSize {
    static let badgeWidth: Double = 90
    static let badgeHeight: Double = 96.15
    static let collectionViewInsets: UIEdgeInsets = .init(top: 52, left: 56, bottom: 52, right: 56)
    static let collectionViewLineSpacing: Double = 25.85
    static let upperBadgeInfoHeight: Double = 56
    static let tableViewRowHeight: Double = 50
    static let tableViewRowWidth: Double = 193
    static let safeAreaTopInset = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
}

final class BoardViewController: BaseViewController {
    // TODO: - 아래의 목데이터를 CoreData로 교체
    let totalBadgeNumber = 5
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
        layout.itemSize = .init(width: view.frame.size.width, height: BoardSize.badgeHeight)

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

// MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath) as? BadgeCollectionViewCell

        if indexPath.row < totalBadgeNumber {
            myCell?.badgeImageView.image = ImageLiteral.coin
        } else {
            myCell?.badgeImageView.image = ImageLiteral.inactiveCoin
        }

        switch indexPath.row % 4 {
        case 0:
            myCell?.frame.size.width = BoardSize.badgeWidth + BoardSize.collectionViewInsets.left // 뱃지크기 + 여백
        case 1, 3:
            myCell?.frame.size.width = Double(view.frame.width / 2) + Double(BoardSize.badgeWidth / 2) // 반 채우고 뱃지 크기 반 만큼
        case 2:
            myCell?.frame.size.width = view.frame.width - BoardSize.collectionViewInsets.right // 전체 너비 - 여백
        default:
            myCell?.frame.size.width = .zero
        }

        return myCell ?? collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath)
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
