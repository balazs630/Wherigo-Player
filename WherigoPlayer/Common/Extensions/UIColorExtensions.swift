//
//  UIColorExtensions.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 14..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import UIKit

extension UIColor {
    static func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        .init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
}
