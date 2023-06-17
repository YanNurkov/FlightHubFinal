//
//  AircraftModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct AircraftDataResponse: Decodable {
    let response: [Aircraft]
}

struct Aircraft: Decodable {
    let hex: String
    let regNumber: String?
    let flag: String?
    let latitude: Double
    let longitude: Double
    let altitude: Int
    let direction: Int
    let speed: Int
    let verticalSpeed: Double?
    let squawk: String?
    let flightNumber: String?
    let flightICAO: String?
    let flightIATA: String?
    let departureICAO: String?
    let departureIATA: String?
    let arrivalICAO: String?
    let arrivalIATA: String?
    let airlineICAO: String?
    let airlineIATA: String?
    let aircraftICAO: String?
    let updated: Int
    let status: String

    private enum CodingKeys: String, CodingKey {
        case hex
        case regNumber = "reg_number"
        case flag
        case latitude = "lat"
        case longitude = "lng"
        case altitude = "alt"
        case direction = "dir"
        case speed
        case verticalSpeed = "v_speed"
        case squawk
        case flightNumber = "flight_number"
        case flightICAO = "flight_icao"
        case flightIATA = "flight_iata"
        case departureICAO = "dep_icao"
        case departureIATA = "dep_iata"
        case arrivalICAO = "arr_icao"
        case arrivalIATA = "arr_iata"
        case airlineICAO = "airline_icao"
        case aircraftICAO = "aircraft_icao"
        case airlineIATA = "airline_iata"
        case updated
        case status
    }
}
