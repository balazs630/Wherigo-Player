//
//  CartridgeDetailsDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 23..
//

import UIKit
import CoreLocation

struct CartridgeDetailsDisplayItem {
    let name: String
    let description: String
    let coordinate: CLLocationCoordinate2D
    let type: String
    let device: String
    let version: String
    let author: String
    let member: String
    let iconImage: UIImage
    let splashImage: UIImage?

    init(cartidgeFile: WIGCartridgeFile) {
        self.name = cartidgeFile.string(forKey: "name_") ?? ""
        self.description = (cartidgeFile.string(forKey: "description__") ?? "").replaceHTMLEntities()

        self.coordinate = CLLocationCoordinate2D(
            latitude: cartidgeFile.double(forKey: "latitude_") ?? 0,
            longitude: cartidgeFile.double(forKey: "longitude_") ?? 0
        )

        self.type = cartidgeFile.string(forKey: "type_") ?? ""
        self.device = cartidgeFile.string(forKey: "device_") ?? ""
        self.version = cartidgeFile.string(forKey: "version__") ?? ""
        self.author = cartidgeFile.string(forKey: "author_") ?? ""
        self.member = cartidgeFile.string(forKey: "member_") ?? ""

        self.iconImage = cartidgeFile.image(for: "iconId_") ?? UIImage(named: "WIGIcon")!
        self.splashImage = cartidgeFile.image(for: "splashId_")
    }
}
