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
    @IBOutlet weak var addBarButton: UIBarButtonItem!

    // MARK: Properties
    private var importerGuideViewController: CartridgeImportGuideViewController?
    private var dataSource: CartridgePickerDataSource!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        fetchCartridgeFiles()
        presentEmptyViewIfNeeded()
        LocationService.shared.startTracking()
    }

    // MARK: Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let importerGuideViewController = UIStoryboard.cartridgePicker
            .instantiateViewController(CartridgeImportGuideViewController.self)
        importerGuideViewController.cartridgeDidImport = { [weak self] in
            importerGuideViewController.dismiss(animated: true)
            self?.fetchCartridgeFiles()
        }
        present(importerGuideViewController, animated: true)
    }

    // MARK: Configuration
    private func configureSelf() {
        configureCartridgeCollectionView()
    }

    private func fetchCartridgeFiles() {
        dataSource = CartridgePickerDataSource(items: CartridgeService.cartridgeFiles())
        cartridgeCollectionView.dataSource = dataSource
        addBarButton.isEnabled = !dataSource.items.isEmpty
    }

    private func configureCartridgeCollectionView() {
        cartridgeCollectionView.delegate = self
        cartridgeCollectionView.register(CartridgePickerCell.self)
    }

    private func presentEmptyViewIfNeeded() {
        guard dataSource.items.isEmpty else {
            removeEmptyView()
            return
        }

        importerGuideViewController = UIStoryboard.cartridgePicker
            .instantiateViewController(CartridgeImportGuideViewController.self)
        importerGuideViewController?.cartridgeDidImport = { [weak self] in
            self?.removeEmptyView()
            self?.fetchCartridgeFiles()
        }
        cartridgeCollectionView.addOverlayingSubView(view: importerGuideViewController!.view)
    }

    private func removeEmptyView() {
        importerGuideViewController?.view.removeFromSuperview()
    }
}

// MARK: UICollectionViewDelegate conformances
extension CartridgePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = dataSource.items[indexPath.row]

        let detailsScreen = UIStoryboard.cartridgeDetails
            .instantiateViewController(CartridgeDetailsViewController.self)
        detailsScreen.cartridgeFile = selectedItem
        detailsScreen.displayItem = .init(cartidgeFile: selectedItem)

        navigationController?.pushViewController(detailsScreen, animated: true)
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
