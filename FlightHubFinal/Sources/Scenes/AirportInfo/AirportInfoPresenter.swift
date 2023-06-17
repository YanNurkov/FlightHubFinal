//
//  AirportInfoPresenter.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

protocol IAirportInfoPresenter: AnyObject {
    func viewDidLoad(ui: IAirportInfoView)
    func fetchCityDetails(for flight: String, completion: @escaping (String?) -> Void)
    func fetchFlightDepartureSchedules()
    func fetchFlightArrivalSchedules()
    func saveAirport(airportCode: String, airportName: String)
}

final class AirportInfoPresenter: IAirportInfoPresenter {
    private var router: RouterProtocol
    private var ui: IAirportInfoView?
    private let dataLoader: APIProtocol
    weak var view: IAirportInfoViewController?
    private var model = CoreDataModel()
    
    required init(router: RouterProtocol, ui: IAirportInfoView, loader: APIProtocol, view: IAirportInfoViewController) {
        self.ui = ui
        self.router = router
        self.dataLoader = loader
        self.view = view
    }
    
    func viewDidLoad(ui: IAirportInfoView) {
        self.ui = ui
    }
    
    func fetchCityDetails(for flight: String, completion: @escaping (String?) -> Void) {
        dataLoader.fetchCityDetails(cityCode: flight) { cityResponse in
            if let departureCity = cityResponse?.response.first {
                completion(departureCity.cityName)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchFlightDepartureSchedules() {
        dataLoader.fetchAirportDepartureSchedules(airportCode: self.ui?.airportCode ?? "") { flightDetails in
            if let details = flightDetails {
                self.ui?.departures = details.response
                DispatchQueue.main.async {
                    self.ui?.departuresTableView.reloadData()
                }
            } else {
                print("Error")
            }
        }
    }
    
    func fetchFlightArrivalSchedules() {
        dataLoader.fetchAirportArrivalSchedules(airportCode: ui?.airportCode ?? "") { flightDetails in
            if let details = flightDetails {
                self.ui?.arrivals = details.response
                DispatchQueue.main.async {
                    self.ui?.arrivalsTableView.reloadData()
                }
            } else {
                print("Error")
            }
        }
    }
    
    func saveAirport(airportCode: String, airportName: String) {
        model.addAirport(airportCodeData: airportCode, airportName: airportName)
    }
}
