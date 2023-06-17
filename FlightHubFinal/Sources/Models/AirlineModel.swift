//
//  AirlineModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct AirlineResponse: Codable {
    let response: [Airline]
}

struct Airline: Codable {
    let name: String
    let icaoCode: String?
    let callsign: String?
    let countryCode: String?
    let totalAircrafts: Int?
    let averageFleetAge: Int?
    let accidentsLast5y: Int?
    let crashesLast5y: Int?
    let website: String?
    let twitter: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case icaoCode = "icao_code"
        case callsign = "callsign"
        case countryCode = "country_code"
        case totalAircrafts = "total_aircrafts"
        case averageFleetAge = "average_fleet_age"
        case accidentsLast5y = "accidents_last_5y"
        case crashesLast5y = "crashes_last_5y"
        case website = "website"
        case twitter = "twitter"
    }
}
