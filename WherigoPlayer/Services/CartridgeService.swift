//
//  CartridgeService.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import Foundation

class CartridgeService {
    static func cartridgeFiles() -> [WIGCartridgeFile] {
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
        guard let documentsStdLibPath = try? FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(Constant.stdLibFileName)
            .appendingPathExtension(Constant.stdLibFileExtension)
            .path
        else {
            return
        }

        if !FileManager.default.fileExists(atPath: documentsStdLibPath) {
            let sourceStdLibPath = Bundle.main.path(
                forResource: Constant.stdLibFileName,
                ofType: Constant.stdLibFileExtension
            )!

            try? FileManager.default.copyItem(atPath: sourceStdLibPath, toPath: documentsStdLibPath)
        }
    }

    static func createLogOutputStream(for cartridgeFile: WIGCartridgeFile) -> WIGFileOutputStream {
        let owlFile = WIGFile(nsString: createOwlFileIfNecessary(for: cartridgeFile))
        return WIGFileOutputStream(javaIoFile: owlFile)
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
        guard let cartridgeFileName = cartridgeFileName(from: cartridgeFile),
              let documentsOWLPath = try? FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(cartridgeFileName)
                .appendingPathExtension(Constant.owlFileExtension)
                .path
        else {
            return nil
        }

        if !FileManager.default.fileExists(atPath: documentsOWLPath) {
            FileManager.default.createFile(atPath: documentsOWLPath, contents: nil)
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
