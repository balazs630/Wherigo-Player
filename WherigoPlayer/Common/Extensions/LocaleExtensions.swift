//
//  LocaleExtensions.swift
//  WherigoPlayer
//
//  Created by Balázs Horváth on 2021. 02. 15..
//

extension Locale {
    func textualLengthRepresentation(of metricValue: Double) -> String {
        if usesMetricSystem {
            if metricValue < UnitLength.kilometers.converter.baseUnitValue(fromValue: 1.0) {
                return "\(Int(metricValue)) m"
            } else {
                return String(
                    format: "%.1f km",
                    Measurement(value: metricValue, unit: UnitLength.meters)
                        .converted(to: UnitLength.kilometers)
                        .value
                )
            }
        } else {
            if metricValue < UnitLength.miles.converter.baseUnitValue(fromValue: 1.0) {
                let value = Int(
                    Measurement(value: metricValue, unit: UnitLength.meters)
                        .converted(to: UnitLength.feet)
                        .value
                )

                return "\(value) feet"
            } else {
                return String(
                    format: "%.1f miles",
                    Measurement(value: metricValue, unit: UnitLength.meters).converted(to: UnitLength.miles).value
                )
            }
        }
    }
}
