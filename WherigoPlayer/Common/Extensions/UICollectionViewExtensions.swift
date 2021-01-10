//
//  UICollectionViewExtensions.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type, bundle: Bundle? = nil) {
        let cellClassName = String(describing: cellType.self)
        let nib = UINib(nibName: cellClassName, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: cellClassName)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T? {
        let cellClassName = String(describing: cellType.self)
        return dequeueReusableCell(withReuseIdentifier: cellClassName, for: indexPath) as? T
    }
}
