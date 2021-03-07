//
//  QuestionDialogDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 03. 07..
//

struct QuestionDialogDisplayItem {
    let texts: [String]
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let callback: WIGLuaClosure

    init(
        texts: IOSObjectArray,
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

        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
        self.callback = callback
    }
}
