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
              let imageData = getWith(imageId).toNSData(),
              let image = UIImage(data: imageData) else {
            return nil
        }

        return image
    }
}
