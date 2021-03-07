//
//  WIGCartridgeFileExtensions.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 31..
//

import UIKit

extension WIGCartridgeFile {
    func image(for key: String) -> UIImage? {
        guard let imageId = value(forKey: key) as? Int32, imageId > 0,
              let byteArray = getWith(imageId)
        else {
            return nil
        }

        return CartridgeService.imageFromByteArray(byteArray)
    }

    func string(forKey key: String) -> String? {
        value(forKey: key) as? String
    }

    func double(forKey key: String) -> Double? {
        value(forKey: key) as? Double
    }
}
