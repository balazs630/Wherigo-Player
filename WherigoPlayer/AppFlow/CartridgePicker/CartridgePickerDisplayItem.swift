//
//  CartridgePickerDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

struct CartridgePickerDisplayItem {
    let name: String
    let iconImage: UIImage

    init(cartidgeFile: WIGCartridgeFile) {
        self.name = cartidgeFile.string(forKey: "name_") ?? ""
        self.iconImage = cartidgeFile.image(for: "iconId_") ?? UIImage(named: "WIGIcon")!
    }
}
