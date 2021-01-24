//
//  UIImageViewExtensions.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 24..
//

import UIKit

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image,
              contentMode == .scaleAspectFit,
              image.size.width > 0 && image.size.height > 0
        else {
            return bounds
        }

        var scale = image.size.width >= image.size.height
            ? bounds.width / image.size.width
            : bounds.height / image.size.height

        if scale > 1 {
            // Preserve image quality, do not scale up
            scale = 1
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)

        let xPosition = (bounds.width - size.width) / 2
        let yPosition = (bounds.height - size.height) / 2

        return .init(x: xPosition, y: yPosition, width: size.width, height: size.height)
    }
}
