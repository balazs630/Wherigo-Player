//
//  CartridgeDetailsDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 23..
//

import UIKit

struct CartridgeDetailsDisplayItem {
    let name: String
    let description: String
    let type: String
    let author: String
    let iconImage: UIImage
    let splashImage: UIImage?

    init(cartidgeFile: WIGCartridgeFile) {
        self.name = (cartidgeFile.value(forKey: "name_") as? String) ?? ""
        self.description = (cartidgeFile.value(forKey: "description__") as? String) ?? ""
        self.type = (cartidgeFile.value(forKey: "type_") as? String) ?? ""
        self.author = (cartidgeFile.value(forKey: "author_") as? String) ?? ""

        if let iconId = cartidgeFile.value(forKey: "iconId_") as? Int32, iconId > 0,
           let iconImageData = cartidgeFile.getWith(iconId).toNSData(),
           let iconImage = UIImage(data: iconImageData) {
            self.iconImage = iconImage
        } else {
            self.iconImage = UIImage(named: "WIGIcon")!
        }

        if let splashId = cartidgeFile.value(forKey: "splashId_") as? Int32, splashId > 0,
           let splashImageData = cartidgeFile.getWith(splashId).toNSData(),
           let splashImage = UIImage(data: splashImageData) {
            self.splashImage = splashImage
        } else {
            self.splashImage = nil
        }
    }
}
