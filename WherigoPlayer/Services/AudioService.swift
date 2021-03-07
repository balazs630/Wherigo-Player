//
//  AudioService.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 03. 07..
//

import AVFoundation

class AudioService {
    static func play(_ sound: IOSByteArray, with mimeType: String) {
        Log.debug("playSound")
    }

    static func playBeep() {
        Log.debug("playBeep")
    }

    static func stop() {
        Log.debug("stopSound")
    }
}
