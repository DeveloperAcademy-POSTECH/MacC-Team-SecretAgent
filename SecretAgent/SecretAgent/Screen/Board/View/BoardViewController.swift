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
}

final class BoardViewController: BaseViewController {
    // MARK: - Properties

    let totalBadgeNumber = 5 // MockData
    let coinBadgeNumber = 5
    let shieldBadgeNumber = 1
    let starBadgeNumber = 0

    private lazy var fixedBadgeInformation: UIStackView = {
        let stackView = UIStackView()

        // MARK: - 아래의 코드는 모두 임시 코드입니다.

        let dropdown = UIButton()
        dropdown.setTitle("드롭다운", for: .normal)
        dropdown.addTarget(self, action: #selector(showDropdown), for: .touchUpInside)
        let coinBadge = UILabel()
        coinBadge.text = "코인뱃지: \(coinBadgeNumber)"
        coinBadge.textAlignment = .center
        let shieldBadge = UILabel()
        shieldBadge.text = "방패뱃지: \(shieldBadgeNumber)"
        shieldBadge.textAlignment = .center
        let starBadge = UILabel()
        starBadge.text = "스타뱃지: \(starBadgeNumber)"
        starBadge.textAlignment = .center
        [dropdown, coinBadge, shieldBadge, starBadge].forEach { subView in
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
    }

    override func configUI() {
        view.backgroundColor = .systemBackground
    }

    // MARK: - Func

    @objc func showDropdown() {
        // TODO: - 드롭다운 보여주기
    }

    private func setDelegation() {
        badgeCollectionView.delegate = self
        badgeCollectionView.dataSource = self
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
