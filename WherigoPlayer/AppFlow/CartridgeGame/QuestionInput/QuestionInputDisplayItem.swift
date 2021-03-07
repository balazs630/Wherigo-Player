//
//  QuestionInputDisplayItem.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 25..
//

import UIKit

struct QuestionInputDisplayItem {
    enum QuestionInputType: String {
        case freeText = "Text"
        case multipleChoice = "MultipleChoice"
    }

    let eventTable: WIGEventTable
    let inputType: QuestionInputType?
    let question: String?
    let media: UIImage?
    let choices: [String]?

    init(eventTable: WIGEventTable) {
        self.eventTable = eventTable

        self.inputType = {
            let rawInputType = eventTable.rawget(withId: "InputType") as? String
            return QuestionInputType(rawValue: rawInputType ?? "")
        }()

        self.question = {
            let text = eventTable.rawget(withId: "Text") as? String
            return text?.replaceHTMLEntities()
        }()

        self.media = {
            let media = eventTable.rawget(withId: "Media") as? WIGMedia
            return CartridgeService.imageFromWIGMedia(media)
        }()

        self.choices = {
            if let choicesTable = eventTable.rawget(withId: "Choices") as? WIGLuaTableImpl {
                var choices = [String?]()
                for index in 1...choicesTable.len() {
                    choices.append(choicesTable.rawget(with: jint(index)) as? String)
                }

                return choices.compactMap { $0 }
            }

            return []
        }()
    }
}
