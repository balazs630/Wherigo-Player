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

        let rawInputType = eventTable.rawget(withId: "InputType") as? String
        self.inputType = QuestionInputType(rawValue: rawInputType ?? "")

        self.question = eventTable.rawget(withId: "Text") as? String

        if let mediaData = eventTable.rawget(withId: "Media") as? Data {
            media = UIImage(data: mediaData)
        } else {
            media = nil
        }

        self.choices = eventTable.rawget(withId: "Choices") as? [String]
    }
}
