//
//  BoardViewController+Extension.swift
//  SecretAgent
//
//  Created by Minkyeong Ko on 2022/11/30.
//

import UIKit

// MARK: - BoardViewController + UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

private enum BoardInfo {
    static let numberOfBadgesPerStar = 25
    static let numberOfBoardCollectionViewCells = 32
    static let numberOfStarBadges = 5
    static let horizontalBoardInset = 50.0
}

// MARK: - BoardViewController + UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BoardInfo.numberOfBoardCollectionViewCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withType: BadgeCollectionViewCell.self, for: indexPath)

        let decreaseAmount = BoardInfo.numberOfBadgesPerStar * curTableViewIndexPath.row
        totalBadgeNumber = totalBadgeNumberFromCoreData - decreaseAmount

        let badgeIndex = indexPath.row
        let shieldNumber = Int(totalBadgeNumber / 5)

        // 뱃지 타입 할당
        if (badgeIndex + 1) % 6 == 0 {
            myCell.badgeType = .shield
        } else {
            myCell.badgeType = .coin
        }
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 2 {
            myCell.badgeType = starBadgeTypes[min(curTableViewIndexPath.row, BoardInfo.numberOfStarBadges - 1)]
        }
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 1 {
            myCell.badgeType = nil
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
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 2, badgeIndex == totalBadgeNumber + shieldNumber {
            myCell.generateActiveImage()
        }
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 1 {
            if allStarsCollected, curTableViewIndexPath.row == BoardInfo.numberOfStarBadges - 1 {
                myCell.generateLastImage()
            } else {
                myCell.generateLastImageTransparent()
            }
        }

        // 위치(크기) 지정
        switch badgeIndex % 4 {
        case 0:
            myCell.frame.size.width = Double(myCell.getBadgeWidth() + BoardInfo.horizontalBoardInset) // 뱃지크기 + 여백
        case 1, 3:
            myCell.frame.size.width = Double(view.frame.size.width / 2) + (myCell.getBadgeWidth() / 2) // 반 채우고 뱃지 크기 반 만큼
        case 2:
            myCell.frame.size.width = view.frame.size.width - BoardInfo.horizontalBoardInset // 전체 너비 - 여백
        default:
            myCell.frame.size.width = .zero
        }
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 2 {
            myCell.frame.size.width = Double(view.frame.size.width / 2) + (myCell.getBadgeWidth() / 2)
        }
        if badgeIndex == BoardInfo.numberOfBoardCollectionViewCells - 1 {
            myCell.frame.size.width = Double(view.frame.size.width / 2) + (myCell.getBadgeWidth() / 2)
        }

        // 이미지 크기 지정
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

        if indexPath.row == 31 {
            itemHeight = BoardSize.mentSize.height
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
        cell.textLabel?.font = .oneMobile(textStyle: .body)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        refreshBoard(targetIndex: indexPath.row)
    }
}
