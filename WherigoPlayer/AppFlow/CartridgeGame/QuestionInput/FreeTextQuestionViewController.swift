//
//  FreeTextQuestionViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 25..
//

import UIKit

class FreeTextQuestionViewController: UIViewController {
    var displayItem: QuestionInputDisplayItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        Log.debug("present free text input screen: \(String(describing: displayItem))")
        // WIGEngine.callEvent(with: displayItem.eventTable, with: "OnGetInput", withId: "en")
    }
}
