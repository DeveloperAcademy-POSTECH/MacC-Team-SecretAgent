//
//  BoardViewController+Extension.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

// MARK: - BoardViewController + UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 31
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withType: BadgeCollectionViewCell.self, for: indexPath)

        let decreaseAmount = 25 * curTableViewIndexPath.row
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
            myCell.badgeType = starBadgeTypes[curTableViewIndexPath.row]
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

// MARK: - BoardViewController + UITableViewDelegate, UITableViewDataSource

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

        curTableViewIndexPath = indexPath

        let decreaseAmount = 25 * indexPath.row
        totalBadgeNumber = totalBadgeNumberFromCoreData - decreaseAmount

        if totalBadgeNumber < 0, indexPath.row > 0 {
            addHideBadgeView(previous: indexPath.row > 0 ? tableViewDataSource[indexPath.row - 1] : nil)
        } else {
            removeHideBadgeView()
        }

        badgeCollectionView.reloadData()

        scrollCollectionView()
    }
}
