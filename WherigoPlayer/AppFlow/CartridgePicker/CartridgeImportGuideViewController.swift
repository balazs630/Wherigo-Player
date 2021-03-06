//
//  CartridgeImportGuideViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 10..
//

import UIKit

class CartridgeImportGuideViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var browseCartridgesLabel: UILabel!
    @IBOutlet private weak var downloadCartridgeLabel: UILabel!
    @IBOutlet private weak var cartridgeFileTypeLabel: UILabel!
    @IBOutlet private weak var importCartridgeLabel: UILabel!

    // MARK: Properties
    var cartridgeDidImport: () -> Void = {}

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTexts()
    }

    // MARK: Configuration
    private func configureTexts() {
        browseCartridgesLabel.attributedText = {
            let attributedText = try? NSMutableAttributedString(
                htmlString: Texts.Import.browseCartridgesStep.localized,
                font: .preferredFont(forTextStyle: .body)
            )

            attributedText?.setLink(for: "wherigo.com", url: Constant.wherigoURL.absoluteString)
            attributedText?.setParagraphStyle(lineSpacing: 4)
            attributedText?.setForegroundColor(color: Theme.Color.blackTurnsWhite)

            return attributedText
        }()

        downloadCartridgeLabel.attributedText = {
            let attributedText = try? NSMutableAttributedString(
                htmlString: Texts.Import.downloadCartridgeStep.localized,
                font: .preferredFont(forTextStyle: .body)
            )

            attributedText?.setParagraphStyle(lineSpacing: 4)
            attributedText?.setForegroundColor(color: Theme.Color.blackTurnsWhite)

            return attributedText
        }()

        cartridgeFileTypeLabel.attributedText = {
            let attributedText = try? NSMutableAttributedString(
                htmlString: Texts.Import.cartridgeFileTypeStep.localized,
                font: .preferredFont(forTextStyle: .body)
            )

            attributedText?.setParagraphStyle(lineSpacing: 4)
            attributedText?.setForegroundColor(color: Theme.Color.blackTurnsWhite)

            return attributedText
        }()

        importCartridgeLabel.attributedText = {
            let attributedText = try? NSMutableAttributedString(
                htmlString: Texts.Import.importCartridgeStep.localized,
                font: .preferredFont(forTextStyle: .body)
            )

            attributedText?.setParagraphStyle(lineSpacing: 4)
            attributedText?.setForegroundColor(color: Theme.Color.blackTurnsWhite)

            return attributedText
        }()
    }

    // MARK: Actions
    @IBAction func wherigoLinkPressed(_ sender: Any) {
        UIApplication.shared.open(Constant.wherigoURL)
    }

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
