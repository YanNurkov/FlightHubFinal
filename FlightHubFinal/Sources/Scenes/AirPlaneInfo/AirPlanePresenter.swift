//
//  AirPlanePresenter.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

protocol IAirPlanePresenter: AnyObject {
    func viewDidLoad(ui: IAirPlaneView)
    func loadData(annotation: String, completion: @escaping (FlightResponse?) -> Void)
    func fetchCityDetails(city: String, completion: @escaping (CityResponse?) -> Void)
    func loadAirlineData(iataCode: String)
    func loadAirlineLogo(iataCode: String)
}

final class AirPlanePresenter: IAirPlanePresenter {
    private var router: RouterProtocol
    private var ui: IAirPlaneView?
    private let dataLoader: APIProtocol
    weak var view: IAirPlaneViewController?
    
    required init(router: RouterProtocol, ui: IAirPlaneView, loader: APIProtocol, view: IAirPlaneViewController) {
        self.ui = ui
        self.router = router
        self.dataLoader = loader
        self.view = view
    }
    
    func viewDidLoad(ui: IAirPlaneView) {
        self.ui = ui
    }
    
    func loadData(annotation: String, completion: @escaping (FlightResponse?) -> Void) {
        self.dataLoader.fetchFlightDetails(flightIATA: annotation) { flightData in
            completion(flightData)
        }
    }
    
    func fetchCityDetails(city: String, completion: @escaping (CityResponse?) -> Void) {
        self.dataLoader.fetchCityDetails(cityCode: city) { city in
            completion(city)
        }
    }
    
    func loadAirlineData(iataCode: String) {
            dataLoader.fetchAirlineData(iataCode: iataCode) { [weak self] airlineResponse in
                guard let airline = airlineResponse?.response.first else {
                    return
                }
                DispatchQueue.main.async {
                    self?.view?.updateAirlineName(string: "\(airline.name) • \(self?.ui?.numberOfFlight ?? "")")
            }
        }
    }
    
    func loadAirlineLogo(iataCode: String) {
            dataLoader.fetchAirlineLogo(iataCode: iataCode) { [weak self] data in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.view?.updateAirlineLogo(with: data)
                    }
                }
            }
        }
}
