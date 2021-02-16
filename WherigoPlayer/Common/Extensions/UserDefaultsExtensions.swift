//
//  UserDefaultsExtensions.swift
//  BadJokes
//
//  Created by Horváth Balázs on 2018. 05. 03..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

extension UserDefaults {
    func printAllUserDefaulsKeysAndValues() {
        UserDefaults.standard.dictionaryRepresentation().forEach { key, value in
            Log.debug("\(key) = \(value) \n")
        }
        Log.debug("=========================================================")
    }
}
