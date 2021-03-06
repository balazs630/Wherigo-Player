//
//  MultipleChoiceQuestionViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 27..
//

import UIKit

class MultipleChoiceQuestionViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answerPickerView: UIPickerView!
    @IBOutlet private weak var doneButton: UIButton!

    // MARK: Properties
    var displayItem: QuestionInputDisplayItem!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Actions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let answerIndex = answerPickerView.selectedRow(inComponent: 0)
        guard displayItem.choices?.indices.contains(answerIndex) != nil else { return }

        let answer = displayItem.choices![answerIndex]
        WIGEngine.callEvent(with: displayItem.eventTable, with: "OnGetInput", withId: answer)

        dismiss(animated: true)
    }

    // MARK: Configuration
    private func configureSelf() {
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }

        questionLabel.text = displayItem.question
        answerPickerView.delegate = self
        answerPickerView.dataSource = self
        doneButton.setTitle(Texts.General.done.localized, for: .normal)
    }
}

// MARK: UIPickerViewDataSource conformances
extension MultipleChoiceQuestionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return displayItem.choices?.count ?? 0
    }
}

// MARK: UIPickerViewDelegate conformances
extension MultipleChoiceQuestionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return displayItem.choices?[row]
    }
}
