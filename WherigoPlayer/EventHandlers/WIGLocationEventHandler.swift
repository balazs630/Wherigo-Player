//
//  WIGLocationEventHandler.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2020. 12. 30..
//

class WIGLocationEventHandler: NSObject, WIGLocationServiceProtocol {
    func getLatitude() -> Double {
        debugPrint("getLatitude")
        return LocationService.shared.location?.coordinate.latitude ?? 47.49
    }

    func getLongitude() -> Double {
        debugPrint("getLongitude")
        return LocationService.shared.location?.coordinate.longitude ?? 19.04
    }

    func getAltitude() -> Double {
        debugPrint("getAltitude")
        return 100
    }

    func getHeading() -> Double {
        debugPrint("getHeading")
        return 0
    }

    func getPrecision() -> Double {
        debugPrint("getPrecision")
        return 5
    }

    func getState() -> Int32 {
        debugPrint("getState")
        return WIGLocationService.ONLINE
    }

    func connect() {
        debugPrint("connect")
    }

    func disconnect() {
        debugPrint("disconnect")
    }
}
