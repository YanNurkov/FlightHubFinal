//
//  APIAdress.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

protocol AirLabsApiAddressProviderProtocol {
    func getBaseURL() -> String
    func getSchedulesEndpoint() -> String
    func getFlightURL(flightIATA: String, apiKey: String) -> URL?
    func getCitiesURL(cityCode: String, apiKey: String) -> URL?
    func getFlightsURL(apiKey: String) -> URL?
    func getSchedulesURL(airportCode: String, apiKey: String) -> URL?
}

class AirLabsApiAddressProvider: AirLabsApiAddressProviderProtocol {
    func getBaseURL() -> String {
        return "https://airlabs.co/api/v9"
    }
    
    func getSchedulesEndpoint() -> String {
        return getBaseURL() + "/schedules"
    }
    
    func getFlightURL(flightIATA: String, apiKey: String) -> URL? {
        let urlString = getBaseURL() + "/flight?flight_iata=\(flightIATA)&api_key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func getCitiesURL(cityCode: String, apiKey: String) -> URL? {
        let urlString = getBaseURL() + "/cities?city_code=\(cityCode)&api_key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func getFlightsURL(apiKey: String) -> URL? {
        let urlString = getBaseURL() + "/flights?api_key=\(apiKey)"
        return URL(string: urlString)
    }
    
    func getSchedulesURL(airportCode: String, apiKey: String) -> URL? {
        let urlString = getBaseURL() + "/schedules?arr_iata=\(airportCode)&api_key=\(apiKey)"
        return URL(string: urlString)
    }
}
