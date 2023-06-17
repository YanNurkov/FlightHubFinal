//
//  AutocompleteResponse.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct AutocompleteResponse: Codable {
    let id: String?
    let type: String?
    let code: String?
    let name: String?
    let countryCode: String?
    let countryName: String?
    let cityCode: String?
    let cityName: String?
    let stateCode: String?
    let coordinates: CoordinatesCity
    let indexStrings: [String]?
    let weight: Int?
    let cases: Cases?
    let cityCases: CityCases?
    let countryCases: CountryCases?
    let mainAirportName: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type, code, name
        case countryCode = "country_code"
        case countryName = "country_name"
        case cityCode = "city_code"
        case cityName = "city_name"
        case stateCode = "state_code"
        case coordinates, indexStrings, weight, cases, cityCases, countryCases
        case mainAirportName = "main_airport_name"
    }
}

struct CoordinatesCity: Codable {
    let lon: Double
    let lat: Double
}

struct Cases: Codable {
    let vi, tv, su, ro, pr, da: String
}

struct CityCases: Codable {
    let vi, tv, su, ro, pr, da: String
}

struct CountryCases: Codable {
    let vi, tv, su, ro, pr, da: String
}
