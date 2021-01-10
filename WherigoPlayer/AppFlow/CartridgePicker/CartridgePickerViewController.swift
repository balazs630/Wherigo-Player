//
//  CartridgePickerViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 03..
//

import UIKit

class CartridgePickerViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var cartridgeCollectionView: UICollectionView!

    // MARK: Properties
    private let dataSource = CartridgePickerDataSource(items: CartridgeService.cartridgeFiles())

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Configuration
    private func configureSelf() {
        configureCartridgeCollectionView()
    }

    private func configureCartridgeCollectionView() {
        cartridgeCollectionView.dataSource = dataSource
        cartridgeCollectionView.delegate = self

        cartridgeCollectionView.register(CartridgePickerCell.self)
    }
}

// MARK: UICollectionViewDelegate conformances
extension CartridgePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = dataSource.items[indexPath.row]
        Log.debug("selected: \(selectedItem)")
    }
}

// MARK: UICollectionViewDelegateFlowLayout conformances
extension CartridgePickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        .init(width: collectionView.frame.width, height: 100)
    }
}
