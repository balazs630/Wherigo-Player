//
//  CartridgePickerCell.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

class CartridgePickerCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!

    // MARK: Properties
    var displayItem: CartridgePickerDisplayItem? {
        didSet {
            nameLabel.text = displayItem?.name
            iconImageView.image = displayItem?.iconImage

            configureCellAppearance()
            layoutIfNeeded()
        }
    }

    // MARK: View Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        iconImageView.image = nil
    }

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size.height = contentView
            .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            .height

        return layoutAttributes
    }

    // MARK: Configuration
    private func configureCellAppearance() {
    }
}
