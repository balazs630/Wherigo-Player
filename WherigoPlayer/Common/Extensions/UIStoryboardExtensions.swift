//
//  UIStoryboardExtensions.swift
//  BadJokes
//
//  Created by Balázs Horváth on 2020. 11. 04..
//  Copyright © 2020. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static let cartridgePicker = UIStoryboard(name: "CartridgePicker", bundle: nil)
    static let cartridgeDetails = UIStoryboard(name: "CartridgeDetails", bundle: nil)
    static let cartridgeGame = UIStoryboard(name: "CartridgeGame", bundle: nil)

    func instantiateViewController<ViewController: UIViewController>(
        _ type: ViewController.Type,
        withIdentifier identifier: String? = nil
    ) -> ViewController {
        let identifier = identifier ?? String(describing: type.self)

        guard let viewController = instantiateViewController(withIdentifier: identifier) as? ViewController else {
            fatalError("Could not instantiate view controller `\(ViewController.self)` with identifier `\(identifier)`")
        }

        return viewController
    }
}
