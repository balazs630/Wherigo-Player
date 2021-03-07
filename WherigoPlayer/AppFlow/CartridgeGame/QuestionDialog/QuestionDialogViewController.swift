//
//  QuestionDialogViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 03. 07..
//

import UIKit

class QuestionDialogViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var primaryButton: UIButton!
    @IBOutlet private weak var secondaryButton: UIButton!

    // MARK: Properties
    var displayItem: QuestionDialogDisplayItem!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Actions
    @IBAction func primaryButtonPressed() {
        WIGEngine.invokeCallback(with: displayItem.callback, withId: "Button1")
        dismiss(animated: true)
    }

    @IBAction func secondaryButtonPressed() {
        WIGEngine.invokeCallback(with: displayItem.callback, withId: "Button2")
        dismiss(animated: true)
    }

    // MARK: Configuration
    private func configureSelf() {
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }

        configureTexts()
        configureButtons()
    }

    private func configureTexts() {
        descriptionLabel.text = displayItem.texts.first
    }

    private func configureButtons() {
        displayItem.primaryButtonTitle.isEmpty
            ? primaryButton.setTitle(Texts.General.ok.localized, for: .normal)
            : primaryButton.setTitle(displayItem.primaryButtonTitle, for: .normal)

        if displayItem.secondaryButtonTitle.isEmpty {
            secondaryButton.isHidden = true
        } else {
            secondaryButton.setTitle(displayItem.secondaryButtonTitle, for: .normal)
        }
    }
}
