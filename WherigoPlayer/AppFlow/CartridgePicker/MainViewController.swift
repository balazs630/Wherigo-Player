//
//  CartridgeCollectionViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 03..
//

// swiftlint:disable force_cast force_try

import UIKit

class CartridgeCollectionViewController: UIViewController {
    // MARK: Properties
    private let gwcFileName = "kbor_kutyk_s_colum"

    private let fileManager = FileManager.default
    private weak var timer: Timer?

    private var documentsStdLibPath: String!
    private var documentsGWCPath: String!
    private var documentsOWLPath: String!

    // MARK: Initializers
    deinit {
        timer?.invalidate()
    }

    @IBAction func importButtonPressed(_ sender: UIButton) {
        Log.debug("importButtonPressed")
        let configuration = FilePickerConfiguration(
            documentTypes: [Constant.cartridgeDocumentTypeIdentifier]
        )

        let filePicker = FilePickerViewController(configuration: configuration)
        present(filePicker, animated: true)
    }

    @IBAction func startGameButtonPressed(_ sender: UIButton) {
        Log.debug("startGameButtonPressed")

        let bundleStdLibPath = Bundle.main.path(
            forResource: Constant.stdLibFileName,
            ofType: Constant.stdLibFileExtension
        )!

        documentsStdLibPath = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(Constant.stdLibFileName)
            .appendingPathExtension(Constant.stdLibFileExtension)
            .path

        documentsGWCPath = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(gwcFileName)
            .appendingPathExtension(Constant.gwcFileExtension)
            .path

        documentsOWLPath = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(gwcFileName)
            .appendingPathExtension(Constant.owlFileExtension)
            .path

        guard isGWCFileExists() else {
            Log.debug("GWC file: `\(gwcFileName)` is not loaded to documents, please import it first!")
            return
        }

        if !isStdLibFileExists() {
            copyDatabase(from: bundleStdLibPath, to: documentsStdLibPath)
        }

        if !isOWLFileExists() {
            fileManager.createFile(atPath: documentsOWLPath, contents: nil)
        }

        let gwcFile = WIGFile(nsString: documentsGWCPath)

        let seekableFile = WIGSeekableFile(javaIoFile: gwcFile)
        let saveFile = WIGSaveFile(javaIoFile: gwcFile)

        let cartFile = WIGCartridgeFile.read(with: seekableFile, with: saveFile)!
        cartFile.setValue(gwcFile.getAbsolutePath(), forKey: "filename_")

        let iconId = cartFile.value(forKey: "iconId_") as! Int32
        let iconImageData = (cartFile.getWith(iconId) ?? IOSByteArray()).toNSData()!
        let iconImage = UIImage(data: iconImageData)

        let splashId = cartFile.value(forKey: "splashId_") as! Int32
        let splashImageData = cartFile.getWith(splashId)!.toNSData()!
        let splashImage = UIImage(data: splashImageData)

        let owlFile = WIGFile(nsString: documentsOWLPath)
        let logOutputStream = WIGFileOutputStream(javaIoFile: owlFile)

        let uiEventHandler = WIGUIEventHandler()
        let locationEventHandler = WIGLocationEventHandler()

        let engine = WIGEngine.newInstance(
            with: cartFile,
            with: logOutputStream,
            with: uiEventHandler,
            with: locationEventHandler
        )!

        engine.start()

        LocationService.shared.startTracking()

        observeCartridgeLoading()
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func cartridgeDidLoad() {
        Log.debug("cartridgeDidLoad()")

        let cartridge = WIGEngine.instance.value(forKey: "cartridge_") as! WIGCartridge
        let visibleZoneCount = cartridge.visibleZones()
        let zones = cartridge.value(forKey: "zones_") as! WIGVector
        let firstZone = zones.getWith(0) as! WIGZone

        let distance = firstZone.value(forKey: "distance_") as! Double
        let firstZoneName = firstZone.description() as! String

        Log.debug("Done.")
    }
}

extension CartridgeCollectionViewController {
    private func isGWCFileExists() -> Bool {
        return fileManager.fileExists(atPath: documentsGWCPath)
    }

    private func isOWLFileExists() -> Bool {
        return fileManager.fileExists(atPath: documentsOWLPath)
    }

    private func isStdLibFileExists() -> Bool {
        return fileManager.fileExists(atPath: documentsStdLibPath)
    }

    private func copyDatabase(from source: String, to destination: String) {
        do {
            try fileManager.copyItem(atPath: source, toPath: destination)
        } catch {
            Log.debug(error)
        }
    }

    private func observeCartridgeLoading() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [unowned self]_ in
            guard WIGEngine.instance.value(forKey: "cartridge_") as? WIGCartridge != nil else { return }
            guard LocationService.shared.location != nil else { return }

            self.timer?.invalidate()
            self.cartridgeDidLoad()
        }
    }
}
