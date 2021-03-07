//
//  Texts.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 24..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

// swiftlint:disable identifier_name

struct Texts {
    enum Import: String, Localizable {
        case browseCartridgesStep
        case downloadCartridgeStep
        case cartridgeFileTypeStep
        case importCartridgeStep
    }

    enum Cartridge: String, Localizable {
        case cartridgeTypeLabel
        case cartridgeVersion
        case cartridgeDistance
        case currentPlayer
        case unknown
    }

    enum General: String, Localizable {
        case start
        case resume
        case restart
        case done
        case ok
    }
}
