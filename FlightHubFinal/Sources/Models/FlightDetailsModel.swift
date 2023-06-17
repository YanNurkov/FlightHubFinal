//
//  FlightDetailsModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct FlightDetails: Codable {
    let response: [Flight]
}

struct Flight: Codable {
    let airlineIATA: String?
    let airlineICAO: String?
    let flightIATA: String?
    let flightICAO: String?
    let flightNumber: String?
    let departureIATA: String?
    let departureICAO: String?
    let departureTerminal: String?
    let departureGate: String?
    let departureTime: String?
    let departureTimeUTC: String?
    let departureEstimated: String?
    let departureEstimatedUTC: String?
    let departureActual: String?
    let departureActualUTC: String?
    let arrivalIATA: String?
    let arrivalICAO: String?
    let arrivalTerminal: String?
    let arrivalGate: String?
    let arrivalBaggage: String?
    let arrivalTime: String?
    let arrivalTimeUTC: String?
    let codeshareAirlineIATA: String?
    let codeshareFlightNumber: String?
    let codeshareFlightIATA: String?
    let status: String?
    let duration: Int?
    let delayed: Int?
    let departureDelayed: Int?
    let arrivalDelayed: Int?
    let aircraftICAO: String?
    let arrivalTimeTS: Int?
    let departureTimeTS: Int?
    let departureEstimatedTS: Int?
    let departureActualTS: Int?
    
    enum CodingKeys: String, CodingKey {
        case airlineIATA = "airline_iata"
        case airlineICAO = "airline_icao"
        case flightIATA = "flight_iata"
        case flightICAO = "flight_icao"
        case flightNumber = "flight_number"
        case departureIATA = "dep_iata"
        case departureICAO = "dep_icao"
        case departureTerminal = "dep_terminal"
        case departureGate = "dep_gate"
        case departureTime = "dep_time"
        case departureTimeUTC = "dep_time_utc"
        case departureEstimated = "dep_estimated"
        case departureEstimatedUTC = "dep_estimated_utc"
        case departureActual = "dep_actual"
        case departureActualUTC = "dep_actual_utc"
        case arrivalIATA = "arr_iata"
        case arrivalICAO = "arr_icao"
        case arrivalTerminal = "arr_terminal"
        case arrivalGate = "arr_gate"
        case arrivalBaggage = "arr_baggage"
        case arrivalTime = "arr_time"
        case arrivalTimeUTC = "arr_time_utc"
        case codeshareAirlineIATA = "cs_airline_iata"
        case codeshareFlightNumber = "cs_flight_number"
        case codeshareFlightIATA = "cs_flight_iata"
        case status
        case duration
        case delayed
        case departureDelayed = "dep_delayed"
        case arrivalDelayed = "arr_delayed"
        case aircraftICAO = "aircraft_icao"
        case arrivalTimeTS = "arr_time_ts"
        case departureTimeTS = "dep_time_ts"
        case departureEstimatedTS = "dep_estimated_ts"
        case departureActualTS = "dep_actual_ts"
    }
}
