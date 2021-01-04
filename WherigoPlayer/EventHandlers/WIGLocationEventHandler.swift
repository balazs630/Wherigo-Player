//
//  WIGLocationEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

class WIGLocationEventHandler: NSObject, WIGLocationServiceProtocol {
    func getLatitude() -> Double {
        Log.debug("getLatitude")
        return LocationService.shared.location?.coordinate.latitude ?? 47.49
    }

    func getLongitude() -> Double {
        Log.debug("getLongitude")
        return LocationService.shared.location?.coordinate.longitude ?? 19.04
    }

    func getAltitude() -> Double {
        Log.debug("getAltitude")
        return 100
    }

    func getHeading() -> Double {
        Log.debug("getHeading")
        return 0
    }

    func getPrecision() -> Double {
        Log.debug("getPrecision")
        return 5
    }

    func getState() -> Int32 {
        Log.debug("getState")
        return WIGLocationService.ONLINE
    }

    func connect() {
        Log.debug("connect")
    }

    func disconnect() {
        Log.debug("disconnect")
    }
}
