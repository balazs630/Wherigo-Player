//
//  QuestionDialogDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 03. 07..
//

import UIKit

struct QuestionDialogDisplayItem {
    let texts: [String]
    let media: [UIImage?]
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let callback: WIGLuaClosure

    init(
        texts: IOSObjectArray,
        media: IOSObjectArray,
        primaryButtonTitle: String,
        secondaryButtonTitle: String,
        callback: WIGLuaClosure
    ) {
        self.texts = {
            var items = [String?]()
            for index in 1...texts.length() {
                items.append(texts.object(at: UInt(index - 1)) as? String)
            }

            return items.compactMap { $0 }
        }()

        self.media = {
            var images = [UIImage?]()
            for index in 1...media.length() {
                let media = media.object(at: UInt(index - 1)) as? WIGMedia
                let image = CartridgeService.imageFromWIGMedia(media)

                images.append(image)
            }

            return images
        }()

        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.callback = callback
    }
}
