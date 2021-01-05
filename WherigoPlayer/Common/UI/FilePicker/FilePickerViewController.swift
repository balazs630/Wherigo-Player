//
//  FilePickerViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

class FilePickerViewController: UIDocumentPickerViewController {
    // MARK: Properties
    private var configuration = FilePickerConfiguration()

    // MARK: Initializers
    override init(documentTypes allowedUTIs: [String], in mode: UIDocumentPickerMode) {
        super.init(documentTypes: allowedUTIs, in: mode)
    }

    convenience init(configuration: FilePickerConfiguration) {
        self.init(documentTypes: configuration.documentTypes, in: configuration.documentPickerMode)
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Configuration
    private func configureSelf() {
        delegate = self
        allowsMultipleSelection = configuration.allowsMultipleSelection
    }
}

// MARK: UIDocumentPickerDelegate conformances
extension FilePickerViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        do {
            try urls.forEach { url in
                Log.debug("didPickDocument: `\(url.lastPathComponent)`")
                let isAccessingUrl = url.startAccessingSecurityScopedResource()

                try FileManager.default.copyItem(
                    at: url,
                    to: configuration.destinationUrl.appendingPathComponent(url.lastPathComponent)
                )

                if isAccessingUrl {
                    url.stopAccessingSecurityScopedResource()
                }
            }
        } catch {
            Log.debug(error)
        }
    }
}
