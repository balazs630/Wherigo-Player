//
//  NSAttributesStringExtension.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 03. 06..
//

import UIKit

extension NSAttributedString {
    convenience init(htmlString: String, font: UIFont) throws {
        let attributedString = try NSMutableAttributedString(
            data: Data(htmlString.utf8),
            options: [
                .documentType: DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil
        )

        let range = NSRange(location: 0, length: attributedString.length)

        attributedString.enumerateAttribute(.font, in: range) { value, range, _ in
            guard let currentFont = value as? UIFont,
               let newFontDescriptor = font.fontDescriptor.withSymbolicTraits(currentFont.fontDescriptor.symbolicTraits)
                else { return }

            attributedString.addAttribute(
                .font,
                value: UIFont(descriptor: newFontDescriptor, size: 0),
                range: range
            )
        }

        self.init(attributedString: attributedString)
    }
}

extension NSMutableAttributedString {
    func addFullRangeAttributes(_ attrs: [NSAttributedString.Key: Any] = [:]) {
        addAttributes(attrs, range: NSRange(location: 0, length: length))
    }

    func setLink(for text: String, url: String) {
        let linkRange = mutableString.range(of: text)
        let isLinkRangeFound = linkRange.location != NSNotFound

        if isLinkRangeFound {
            addAttribute(.link, value: url, range: linkRange)
        }
    }

    func setParagraphStyle(lineSpacing: Int) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4

        addFullRangeAttributes([
            .paragraphStyle: paragraphStyle
        ])
    }

    func setForegroundColor(color: UIColor) {
        addFullRangeAttributes([
            .foregroundColor: color
        ])
    }
}
