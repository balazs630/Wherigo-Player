//
//  MultipleChoiceQuestionViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 27..
//

import UIKit

class MultipleChoiceQuestionViewController: UIViewController {
    var displayItem: QuestionInputDisplayItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        Log.debug("present multiple choice input screen: \(String(describing: displayItem))")
    }
}
