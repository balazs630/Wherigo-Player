//
//  CartridgeDetailsViewController.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 23..
//

import UIKit

class CartridgeDetailsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
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

    // MARK: Configuration
    private func configureSelf() {
        configureTexts()
        configureSplashImage()
    }

    private func configureTexts() {
        titleLabel.text = displayItem.name
        descriptionLabel.text = displayItem.description
    }

    private func configureSplashImage() {
        splashImageView.image = displayItem.splashImage
        splashImageHeightConstraint.constant = splashImageView.contentClippingRect.height
    }
}
