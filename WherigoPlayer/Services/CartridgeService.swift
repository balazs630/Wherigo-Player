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

            return WIGCartridgeFile.read(with: seekableFile, with: saveFile)
        }
    }

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
}
