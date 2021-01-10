//
//  CartridgePickerDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

struct CartridgePickerDisplayItem {
    let name: String
    let type: String
    let author: String
    let iconImage: UIImage

    init(cartidgeFile: WIGCartridgeFile) {
        self.name = (cartidgeFile.value(forKey: "name_") as? String) ?? ""
        self.type = (cartidgeFile.value(forKey: "type_") as? String) ?? ""
        self.author = (cartidgeFile.value(forKey: "author_") as? String) ?? ""

        if let iconId = cartidgeFile.value(forKey: "iconId_") as? Int32, iconId > 0,
           let iconImageData = cartidgeFile.getWith(iconId).toNSData(),
           let iconImage = UIImage(data: iconImageData) {
            self.iconImage = iconImage
        } else {
            self.iconImage = UIImage(named: "WIGIcon")!
        }
    }
}
