//
//  AirportModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct Airport: Codable {
    let cityCode: String?
    let countryCode: String?
    let nameTranslations: NameTranslations
    let timeZone: String?
    let flightable: Bool?
    let coordinates: Coordinates
    let name: String?
    let code: String?
    let iataType: String?

    enum CodingKeys: String, CodingKey {
        case cityCode = "city_code"
        case countryCode = "country_code"
        case nameTranslations = "name_translations"
        case timeZone = "time_zone"
        case flightable, coordinates, name, code
        case iataType = "iata_type"
    }
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct NameTranslations: Codable {
    let en: String?
}
