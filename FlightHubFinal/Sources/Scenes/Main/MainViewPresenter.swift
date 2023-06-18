//
//  MainViewPresenter.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

protocol IMainViewPresenter: AnyObject {
    func viewDidLoad(ui: IMainScreenView)
    func getAirport()
    func getAirplane()
    func showDetailAirplane(annotation: AircraftAnnotation, allAirports: [Airport])
    func showAirportDetail(annotation: AirportAnnotation)
    func showFavoritesScreen()
    func searchTextDidChange(_ searchText: String)
}

final class MainViewPresenter: IMainViewPresenter {
    private var router: RouterProtocol
    private var ui: IMainScreenView?
    private let dataLoader: APIProtocol
    weak var view: IMainView?
    private let netWork = NetworkService()
    
    required init(router: RouterProtocol, ui: IMainScreenView, loader: APIProtocol, view: IMainView) {
        self.ui = ui
        self.router = router
        self.dataLoader = loader
        self.view = view
    }
    
    func viewDidLoad(ui: IMainScreenView) {
        self.ui = ui
    }
    
    func getAirport() {
        self.dataLoader.loadAirportData { airports in
            if let airports = airports {
                self.view?.parseAirportData(airports)
            }
        }
    }
    
    func getAirplane() {
        dataLoader.loadAircraftData { aircraftDataResponse in
            if let aircraftData = aircraftDataResponse?.response {
                DispatchQueue.main.async {
                    self.view?.updateAircraftAnnotations(aircraftData)
                    self.ui?.label.isHidden = true
                }
            } else {
                print("Error fetching aircraft data")
                if self.view?.hasShownErrorAlert == false {
                    self.view?.hasShownErrorAlert = true
                    DispatchQueue.main.async {
                        self.ui?.label.isHidden = false
                        let alert = Alert.errorData
                        self.view?.displayAlertStatusSave(with: alert)
                    }
                }
            }
        }
    }
    
    func showDetailAirplane(annotation: AircraftAnnotation, allAirports: [Airport]) {
        self.router.showAirPlaneInfo(annotation: annotation, allAirports: allAirports)
    }
    
    func showAirportDetail(annotation: AirportAnnotation) {
        self.router.showAirportInfo(annotation: annotation)
    }
    
    func showFavoritesScreen() {
        self.router.showFavoriteView()
    }
    
    func searchTextDidChange(_ searchText: String) {
        if searchText.isEmpty {
            self.view?.suggestions.removeAll()
            self.ui?.tableView.isHidden = true
        } else {
            self.view?.reloadTable()
            self.ui?.tableView.isHidden = false
        }
        
        self.netWork.fetchSuggestions(with: searchText) { [weak self] autocompleteResponses in
            self?.view?.suggestions = autocompleteResponses
            self?.view?.reloadTable()
            self?.ui?.tableView.isHidden = false
        }
    }
}
