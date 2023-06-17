//
//  AircraftAnnotation.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit
import MapKit

class AircraftAnnotation: MKPointAnnotation {
    var trueTrack: Double = 0.0
    var fullFlightNumber: String = ""
    var flightNumber: String = ""
    var regNumber: String = ""
    var flag: String = ""
    var altitude: Int = 0
    var direction: Int = 0
    var speed: Int = 0
    var verticalSpeed: Double = 0.0
    var arrivalICAO: String = ""
    var arrivalIATA: String = ""
    var airlineICAO: String = ""
    var aircraftICAO: String = ""
    var flightICAO: String = ""
    var flightIATA: String = ""
    var departureICAO: String = ""
    var departureIATA: String = ""
    var airlineIATA: String = ""
}

class CustomAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            subviews.forEach { $0.removeFromSuperview() }
        }
    }
}

class AirportAnnotation: MKPointAnnotation {
    var lat: Double = 0.0
    var lon: Double = 0.0
}

class CustomAirportAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet {
            subviews.forEach { $0.removeFromSuperview() }
        }
    }
}

