//
//  LocationService.swift
//  WhereIGoPlayer
//
//  Created by Balázs Horváth on 2018. 11. 03..
//

import CoreLocation

class LocationService: NSObject {
    // MARK: Properties
    static let shared = LocationService()
    private var locationManager: CLLocationManager

    var location: CLLocation? {
        return locationManager.location
    }

    var coordinates: CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }

    // MARK: Initializers
    private override init() {
        locationManager = CLLocationManager()
        super.init()
    }
}

// MARK: Public methods
extension LocationService {
    func startTracking() {
        requestLocationPermission()
        locationManager.startUpdatingLocation()
    }

    func distance(from coordinate: CLLocationCoordinate2D) -> String? {
        let destinationLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        guard let distance = location?.distance(from: destinationLocation),
              distance != 0
        else {
            return nil
        }

        return Locale.current.textualLengthRepresentation(of: distance)
    }

    func authorizationStatus() -> CLAuthorizationStatus {
        CLLocationManager.authorizationStatus()
    }

    func locationAccuracy() -> Double? {
        guard let horizontalAccuracy = location?.horizontalAccuracy, horizontalAccuracy > 0,
              let verticalAccuracy = location?.verticalAccuracy, verticalAccuracy > 0
        else { return nil }

        return (horizontalAccuracy + verticalAccuracy) / 2
    }
}

// MARK: Private methods
extension LocationService {
    private func requestLocationPermission() {
        if !isAccessGranted() {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    private func isAccessGranted() -> Bool {
        switch authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .notDetermined, .restricted, .denied:
            return false
        @unknown default:
            return false
        }
    }
}

// MARK: CLLocationManagerDelegate methods
extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        Log.debug(error)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            locationManager.stopUpdatingLocation()
        case .notDetermined, .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}
