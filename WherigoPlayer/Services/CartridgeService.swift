//
//  CartridgeService.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

class CartridgeService {
    static var cartridgeFiles: [WIGCartridgeFile] {
        wigFiles().compactMap {
            let seekableFile = WIGSeekableFile(javaIoFile: $0)
            let saveFile = WIGSaveFile(javaIoFile: $0)

            let cartridgeFile = WIGCartridgeFile.read(with: seekableFile, with: saveFile)
            if let cartridgePath = $0.value(forKey: "path_") as? String {
                cartridgeFile?.setValue(cartridgePath, forKey: "filename_")
            }

            return cartridgeFile
        }
    }

    static func copyLuaStdLibIfNecessary() {
        let fileManager = FileManager.default

        guard let documentsStdLibPath = try? fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(Constant.stdLibFileName)
            .appendingPathExtension(Constant.stdLibFileExtension)
            .path
        else {
            return
        }

        if !fileManager.fileExists(atPath: documentsStdLibPath) {
            let sourceStdLibPath = Bundle.main.path(
                forResource: Constant.stdLibFileName,
                ofType: Constant.stdLibFileExtension
            )!

            try? fileManager.copyItem(atPath: sourceStdLibPath, toPath: documentsStdLibPath)
        }
    }

    static func startWIGEngine(
        cartridgeFile: WIGCartridgeFile,
        uiEventHandler: WIGUIEventHandler,
        locationEventHandler: WIGLocationEventHandler,
        completion: @escaping (WIGCartridge) -> Void
    ) {
        let logOutputStream = createLogOutputStream(for: cartridgeFile)

        guard let engine = WIGEngine.newInstance(
            with: cartridgeFile,
            with: logOutputStream,
            with: uiEventHandler,
            with: locationEventHandler
        ) else {
            return
        }

        engine.start()

        var enginePollingTimer: Timer?
        enginePollingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            // Starting engine takes time, we're polling when it's ready for use
            guard let cartridge = WIGEngine.instance.value(forKey: "cartridge_") as? WIGCartridge else { return }

            enginePollingTimer?.invalidate()
            completion(cartridge)
        }
    }

    static func createLogOutputStream(for cartridgeFile: WIGCartridgeFile) -> WIGFileOutputStream {
        let owlFile = WIGFile(nsString: createOwlFileIfNecessary(for: cartridgeFile))
        return WIGFileOutputStream(javaIoFile: owlFile)
    }

    static func stopWIGEngine() {
        WIGEngine.kill()
    }

    static func hasSavedPlay(for cartridgeFile: WIGCartridgeFile) -> Bool {
        return false
    }
}

// MARK: Private methods
extension CartridgeService {
    private static func wigFiles() -> [WIGFile] {
        gwcFileURLs().map { WIGFile(nsString: $0.path) }
    }

    private static func gwcFileURLs() -> [URL] {
        let fileManager = FileManager.default

        do {
            return try fileManager.contentsOfDirectory(
                at: fileManager.documentsDirectory,
                includingPropertiesForKeys: nil
            ).filter { $0.pathExtension == Constant.gwcFileExtension }
        } catch {
            Log.debug(error)
            return []
        }
    }

    private static func createOwlFileIfNecessary(for cartridgeFile: WIGCartridgeFile) -> String? {
        let fileManager = FileManager.default

        guard let cartridgeFileName = cartridgeFileName(from: cartridgeFile),
              let documentsOWLPath = try? fileManager
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(cartridgeFileName)
                .appendingPathExtension(Constant.owlFileExtension)
                .path
        else {
            return nil
        }

        if !fileManager.fileExists(atPath: documentsOWLPath) {
            fileManager.createFile(atPath: documentsOWLPath, contents: nil)
        }

        return documentsOWLPath
    }

    private static func cartridgeFileName(from cartridgeFile: WIGCartridgeFile) -> String? {
        guard let cartridgeFileAbsolutePath = cartridgeFile.value(forKey: "filename_") as? String,
              let lastPathComponent = URL(string: cartridgeFileAbsolutePath)?.lastPathComponent
        else {
            return nil
        }

        return lastPathComponent
    }
}
