//
//  CartridgePickerDataSource.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

class CartridgePickerDataSource: NSObject {
    let items: [WIGCartridgeFile]

    init(items: [WIGCartridgeFile]) {
        self.items = items
    }
}

// MARK: UICollectionViewDataSource conformances
extension CartridgePickerDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CartridgePickerCell.self, for: indexPath)!
        cell.displayItem = .init(cartidgeFile: items[indexPath.row])

        return cell
    }
}
