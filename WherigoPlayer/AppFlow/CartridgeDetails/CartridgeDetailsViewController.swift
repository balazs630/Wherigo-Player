//
//  CartridgeDetailsViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 23..
//

import UIKit

class CartridgeDetailsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!

    @IBOutlet private weak var buttonStackView: UIStackView!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var resumeButton: UIButton!
    @IBOutlet private weak var restartButton: UIButton!

    @IBOutlet private weak var cartridgeVersionDescriptionLabel: UILabel!
    @IBOutlet private weak var cartridgeVersionLabel: UILabel!
    @IBOutlet private weak var cartridgeDistanceDescriptionLabel: UILabel!
    @IBOutlet private weak var cartridgeDistanceLabel: UILabel!
    @IBOutlet private weak var cartridgeCurrentPlayerDescriptionLabel: UILabel!
    @IBOutlet private weak var cartridgeCurrentPlayerLabel: UILabel!

    @IBOutlet private weak var splashImageView: UIImageView!
    @IBOutlet private weak var splashImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: Properties
    var cartridgeFile: WIGCartridgeFile!
    var displayItem: CartridgeDetailsDisplayItem!

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSelf()
    }

    // MARK: Actions
    @IBAction func startButtonPressed(_ sender: Any) {
        let gameScreen = UIStoryboard.cartridgeGame
            .instantiateViewController(CartridgeGameViewController.self)
        gameScreen.cartridgeFile = cartridgeFile

        navigationController?.pushViewController(gameScreen, animated: true)
    }

    @IBAction func resumeButtonPressed(_ sender: Any) {
        // TODO: Button action
    }

    @IBAction func restartButtonPressed(_ sender: Any) {
        // TODO: Button action
    }

    // MARK: Configuration
    private func configureSelf() {
        configureTexts()
        configureButtons()
        configureImages()
    }

    private func configureTexts() {
        titleLabel.text = displayItem.name
        subTitleLabel.text = !displayItem.author.isEmpty
            ? Texts.General.cartridgeTypeLabel.localizedWithParameter(displayItem.type, displayItem.author)
            : displayItem.type

        cartridgeVersionDescriptionLabel.text = Texts.General.cartridgeVersion.localized
        cartridgeVersionLabel.text = displayItem.version

        cartridgeDistanceDescriptionLabel.text = Texts.General.cartridgeDistance.localized
        let distance = LocationService.shared.distance(from: displayItem.coordinate)
        cartridgeDistanceLabel.text = distance != nil
            ? distance
            : Texts.General.unknown.localized

        cartridgeCurrentPlayerDescriptionLabel.text = Texts.General.currentPlayer.localized
        cartridgeCurrentPlayerLabel.text = displayItem.member

        descriptionLabel.text = displayItem.description
    }

    private func configureButtons() {
        if CartridgeService.hasSavedPlay(for: cartridgeFile) {
            resumeButton.setTitle(Texts.General.resume.localized, for: .normal)
            restartButton.setTitle(Texts.General.restart.localized, for: .normal)
            restartButton.setTitleColor(Theme.Color.blackTurnsWhite, for: .normal)
            startButton.isHidden = true
        } else {
            startButton.setTitle(Texts.General.start.localized, for: .normal)
            resumeButton.isHidden = true
            restartButton.isHidden = true
        }
    }

    private func configureImages() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 20
        iconImageView.image = displayItem.iconImage

        splashImageView.image = displayItem.splashImage
        splashImageHeightConstraint.constant = displayItem.splashImage != nil
            ? splashImageView.contentClippingRect.height
            : 0
    }
}
