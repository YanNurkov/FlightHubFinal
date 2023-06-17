//
//  FlightDataModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct FlightResponse: Codable {
    let response: FlightData
}

struct FlightData: Codable {
    let hex: String?
    let regNumber: String?
    let aircraftICAO: String?
    let flag: String?
    let latitude: Double?
    let longitude: Double?
    let altitude: Int?
    let direction: Int?
    let speed: Int?
    let verticalSpeed: Double?
    let squawk: String?
    let airlineICAO: String?
    let airlineIATA: String?
    let flightNumber: String?
    let flightICAO: String?
    let flightIATA: String?
    let csAirlineIATA: String?
    let csFlightNumber: String?
    let csFlightIATA: String?
    let departureICAO: String?
    let departureIATA: String?
    let departureTerminal: String?
    let departureGate: String?
    let departureTime: String?
    let departureTimeTimestamp: Int?
    let departureTimeUTC: String?
    let arrivalICAO: String?
    let arrivalIATA: String?
    let arrivalTerminal: String?
    let arrivalGate: String?
    let arrivalBaggage: String?
    let arrivalTime: String?
    let arrivalTimeTimestamp: Int?
    let arrivalTimeUTC: String?
    let duration: Int?
    let delayed: Int?
    let updated: Int?
    let status: String?
    let age: Int?
    let built: Int?
    let engine: String?
    let engineCount: String?
    let model: String?
    let manufacturer: String?
    let msn: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case hex
        case regNumber = "reg_number"
        case aircraftICAO = "aircraft_icao"
        case flag
        case latitude = "lat"
        case longitude = "lng"
        case altitude = "alt"
        case direction = "dir"
        case speed
        case verticalSpeed = "v_speed"
        case squawk
        case airlineICAO = "airline_icao"
        case airlineIATA = "airline_iata"
        case flightNumber = "flight_number"
        case flightICAO = "flight_icao"
        case flightIATA = "flight_iata"
        case csAirlineIATA = "cs_airline_iata"
        case csFlightNumber = "cs_flight_number"
        case csFlightIATA = "cs_flight_iata"
        case departureICAO = "dep_icao"
        case departureIATA = "dep_iata"
        case departureTerminal = "dep_terminal"
        case departureGate = "dep_gate"
        case departureTime = "dep_time"
        case departureTimeTimestamp = "dep_time_ts"
        case departureTimeUTC = "dep_time_utc"
        case arrivalICAO = "arr_icao"
        case arrivalIATA = "arr_iata"
        case arrivalTerminal = "arr_terminal"
        case arrivalGate = "arr_gate"
        case arrivalBaggage = "arr_baggage"
        case arrivalTime = "arr_time"
        case arrivalTimeTimestamp = "arr_time_ts"
        case arrivalTimeUTC = "arr_time_utc"
        case duration
        case delayed
        case updated
        case status
        case age
        case built
        case engine
        case engineCount = "engine_count"
        case model
        case manufacturer
        case msn
        case type
    }
}
