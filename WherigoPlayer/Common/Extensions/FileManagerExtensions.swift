//
//  FileManagerExtensions.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 01. 05..
//

extension FileManager {
    var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
