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
    let choices: [String]?

    init(eventTable: WIGEventTable) {
        self.eventTable = eventTable

        let rawInputType = eventTable.rawget(withId: "InputType") as? String
        self.inputType = QuestionInputType(rawValue: rawInputType ?? "")

        self.question = (eventTable.rawget(withId: "Text") as? String)?
            .replacingOccurrences(of: "<BR>", with: "")

        if let choicesTable = eventTable.rawget(withId: "Choices") as? WIGLuaTableImpl {
            var choices = [String]()
            for index in 1...choicesTable.len() {
                choices.append((choicesTable.rawget(with: jint(index)) as? String) ?? "-")
            }

            self.choices = choices
        } else {
            self.choices = []
        }
    }
}
