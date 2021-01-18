//
//  CartridgeImportGuideViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 10..
//

import UIKit

class CartridgeImportGuideViewController: UIViewController {
    // MARK: Properties
    var cartridgeDidImport: () -> Void = {}

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Actions
    @IBAction func importButtonPressed(_ sender: UIButton) {
        let configuration = FilePickerConfiguration(
            documentTypes: [Constant.cartridgeDocumentTypeIdentifier]
        )

        let filePicker = FilePickerViewController(configuration: configuration)
        filePicker.didPickDocuments = { [weak self] in
            self?.cartridgeDidImport()
        }
        present(filePicker, animated: true)
    }
}
