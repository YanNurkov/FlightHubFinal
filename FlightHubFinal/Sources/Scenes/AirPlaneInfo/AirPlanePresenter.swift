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
        dataLoader.fetchFlightDetails(flightIATA: annotation) { flightData in
            completion(flightData)
        }
    }
    
    func fetchCityDetails(city: String, completion: @escaping (CityResponse?) -> Void) {
        dataLoader.fetchCityDetails(cityCode: city) { city in
            completion(city)
        }
    }
}


