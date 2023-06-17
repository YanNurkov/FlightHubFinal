//
//  CityModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

struct CityResponse: Codable {
    let response: [City]
}

struct City: Codable {
    let cityCode: String
    let cityName: String
    let countryCode: String
    
    enum CodingKeys: String, CodingKey {
        case cityCode = "city_code"
        case cityName = "name"
        case countryCode = "country_code"
    }
}
