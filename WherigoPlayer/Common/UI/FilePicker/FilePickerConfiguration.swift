//
//  FilePickerConfiguration.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

import UIKit

struct FilePickerConfiguration {
    var documentTypes = ["kUTTypeData"]
    var documentPickerMode = UIDocumentPickerMode.open
    var allowsMultipleSelection = true
    var destinationUrl = FileManager.default.documentsDirectory
}
