//
//  FreeTextQuestionViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 25..
//

import UIKit

class FreeTextQuestionViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var answerTextField: UITextField!
    @IBOutlet private weak var doneButton: UIButton!

    // MARK: Properties
    var displayItem: QuestionInputDisplayItem!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
        addKeyboardObservers()
    }

    deinit {
        removeKeyboardObservers()
    }

    // MARK: Actions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let answer = answerTextField.text ?? ""
        WIGEngine.callEvent(with: displayItem.eventTable, with: "OnGetInput", withId: answer)

        dismiss(animated: true)
    }

    // MARK: Configuration
    private func configureSelf() {
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }

        questionLabel.text = displayItem.question
        doneButton.setTitle(Texts.General.done.localized, for: .normal)
    }

    // MARK: Keyboard events
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
        else { return }

        scrollView.contentInset.bottom = keyboardRect.height
        scrollView.scrollIndicatorInsets = .zero
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
    }
}
