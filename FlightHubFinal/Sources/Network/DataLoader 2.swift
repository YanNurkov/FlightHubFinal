//
//  DataLoader.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Alamofire
import UIKit

typealias AirportDataHandler = ([Airport]?) -> Void
typealias AircraftDataHandler = (AircraftDataResponse?) -> Void
typealias CityDetailsHandler = (CityResponse?) -> Void
typealias FlightDetailsHandler = (FlightResponse?) -> Void

protocol AirportDataLoader {
    func loadAirportData(completion: @escaping AirportDataHandler)
}

protocol AircraftDataLoader {
    func loadAircraftData(completion: @escaping AircraftDataHandler)
}

protocol CityDetailsLoader {
    func fetchCityDetails(cityCode: String, completion: @escaping CityDetailsHandler)
}

protocol FlightDetailsLoader {
    func fetchFlightDetails(flightIATA: String, completion: @escaping FlightDetailsHandler)
}
protocol AirportDepartureLoader {
    func fetchAirportDepartureSchedules(airportCode: String, completion: @escaping (FlightDetails?) -> Void)
    func fetchAirportArrivalSchedules(airportCode: String, completion: @escaping (FlightDetails?) -> Void)
}

protocol APIProtocol: AirportDataLoader, AircraftDataLoader, CityDetailsLoader, FlightDetailsLoader, AirportDepartureLoader, AnyObject {
    func loadAirportData(completion: @escaping AirportDataHandler)
    func loadAircraftData(completion: @escaping AircraftDataHandler)
    func fetchCityDetails(cityCode: String, completion: @escaping CityDetailsHandler)
    func fetchFlightDetails(flightIATA: String, completion: @escaping FlightDetailsHandler)
    func fetchAirportDepartureSchedules(airportCode: String, completion: @escaping (FlightDetails?) -> Void)
}

class DataLoader: APIProtocol {
    let addressProvider = AirLabsApiAddressProvider()
    
    func loadAirportData(completion: @escaping AirportDataHandler) {
        guard let url = URL(string: "https://api.travelpayouts.com/data/ru/airports.json?_gl=1*1ca70wn*_ga*MTA2ODI2MjU2My4xNjg2Mzk2NTM2*_ga_1WLL0NEBEH*MTY4NjM5NjYzOC4xLjEuMTY4NjM5Njc5Ni4zNS4wLjA") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: [Airport].self) { response in
            switch response.result {
            case .success(let airports):
                completion(airports)
            case .failure(let error):
                print("Error fetching airport data: \(error)")
                completion(nil)
            }
        }
    }
    
    func loadAircraftData(completion: @escaping AircraftDataHandler) {
            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
            guard let url = addressProvider.getFlightsURL(apiKey: apiKey) else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            AF.request(url).responseDecodable(of: AircraftDataResponse.self) { response in
                switch response.result {
                case .success(let aircraftDataResponse):
                    completion(aircraftDataResponse)
                case .failure(let error):
                    print("Error fetching aircraft data: \(error)")
                    completion(nil)
                }
            }
        }
    
    func fetchCityDetails(cityCode: String, completion: @escaping CityDetailsHandler) {
            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
            guard let url = addressProvider.getCitiesURL(cityCode: cityCode, apiKey: apiKey) else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            AF.request(url).responseDecodable(of: CityResponse.self) { response in
                switch response.result {
                case .success(let cityResponse):
                    completion(cityResponse)
                case .failure(let error):
                    print("Error fetching city details: \(error)")
                    completion(nil)
                }
            }
        }

    func fetchFlightDetails(flightIATA: String, completion: @escaping FlightDetailsHandler) {
            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
            guard let url = addressProvider.getFlightURL(flightIATA: flightIATA, apiKey: apiKey) else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            AF.request(url).responseDecodable(of: FlightResponse.self) { response in
                switch response.result {
                case .success(let flightResponse):
                    completion(flightResponse)
                case .failure(let error):
                    print("Error fetching flight details: \(error)")
                    completion(nil)
                }
            }
        }

    func fetchAirportDepartureSchedules(airportCode: String, completion: @escaping (FlightDetails?) -> Void) {
            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
            guard let url = addressProvider.getSchedulesURL(airportCode: airportCode, apiKey: apiKey) else {
                print("Invalid URL")
                completion(nil)
                return
            }
            
            AF.request(url).responseDecodable(of: FlightDetails.self) { response in
                switch response.result {
                case .success(let flightResponse):
                    completion(flightResponse)
                case .failure(let error):
                    print("Error fetching flight details: \(error)")
                    completion(nil)
                }
            }
        }

    func fetchAirportArrivalSchedules(airportCode: String, completion: @escaping (FlightDetails?) -> Void) {
        let apiKey = retrieveAPIKeyFromKeychain() ?? ""
        guard let url = addressProvider.getSchedulesURL(airportCode: airportCode, apiKey: apiKey) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        AF.request(url).responseDecodable(of: FlightDetails.self) { response in
            switch response.result {
            case .success(let flightResponse):
                completion(flightResponse)
            case .failure(let error):
                print("Error fetching flight details: \(error)")
                completion(nil)
            }
        }
    }
}
