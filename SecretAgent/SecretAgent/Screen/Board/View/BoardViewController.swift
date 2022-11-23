//
//  BoardViewController.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/23.
//

import UIKit

final class BoardViewController: BaseViewController {
    // MARK: - Properties

    private lazy var badgeCollectionFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: 52, left: 56, bottom: 52, right: 56)
        layout.itemSize = .init(width: view.frame.size.width, height: 90)

        return layout
    }()

    private lazy var badgeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: badgeCollectionFlowLayout)
        collectionView.register(cell: CustomCollectionViewCell.self, forCellReuseIdentifier: "CustomCollectionViewCell")
        collectionView.backgroundColor = .blue
        return collectionView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        print("viewdidload")
        super.viewDidLoad()
        view.backgroundColor = .purple

        view.addSubview(badgeCollectionView)
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
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell

        myCell?.frame.size.width = 90 * Double(indexPath.row % 4) + 10 * Double(indexPath.row % 4)

        switch indexPath.row % 4 {
        case 0:
            myCell?.frame.size.width = 90
        case 1, 3:
            myCell?.frame.size.width = view.frame.width / 2 + 45
        case 2:
            myCell?.frame.size.width = view.frame.width
        default:
            myCell?.frame.size.width = 0
        }

        return myCell ?? collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
