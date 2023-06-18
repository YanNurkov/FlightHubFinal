//
//  AirportInfoViewController.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit
import MapKit

protocol IAirportInfoViewController: AnyObject {
    
}

class AirportInfoViewController: UIViewController, IAirportInfoViewController {
    var ui = AirportInfoView()
    var presenter: IAirportInfoPresenter?
    var annotation = AirportAnnotation()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.ui)
        self.getCityNameFromLocation()
        self.setupTableViewDelegatesAndDataSources()
        self.updateAirportInfoFromAnnotation()
        self.getShedules()
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    // MARK: - Init
    
    init(annotation: AirportAnnotation) {
        super.init(nibName: nil, bundle: nil)
        self.annotation = annotation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Acrions
    
    @objc func saveButtonTapped() {
        self.presenter?.saveAirport(airportCode: annotation.subtitle ?? "", airportName: annotation.title ?? "")
    }
    
    // MARK: - Functions
    
    func getCityNameFromLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "ru_RU")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let placemark = placemarks?.first {
                if let city = placemark.locality {
                    completion(city)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}

// MARK: - Extensions

private extension AirportInfoViewController {
    private func getCityNameFromLocation() {
        self.getCityNameFromLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude) { cityName in
            if let cityName = cityName {
                self.ui.airportNameData = "\(self.annotation.title ?? ""), \nгород \(cityName)"
            } else {
                print("Unable to get the city name.")
            }
        }
    }
    
    private func setupTableViewDelegatesAndDataSources() {
        self.ui.departureTableDataSource = self
        self.ui.departureTableViewDelegate = self
        self.ui.arrivalTableDataSource = self
        self.ui.arrivalTableViewDelegate = self
    }
    
    private func updateAirportInfoFromAnnotation() {
        self.ui.airportNameData = annotation.title
        self.ui.airportCodeData = annotation.subtitle
    }
    
    private func getShedules() {
        self.presenter?.fetchFlightDepartureSchedules()
        self.presenter?.fetchFlightArrivalSchedules()
    }
}

extension AirportInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.ui.departuresTableView {
            return self.ui.departures.count
        } else if tableView == self.ui.arrivalsTableView {
            return self.ui.arrivals.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightCell.identifier, for: indexPath) as! FlightCell
        let flight: Flight
        
        if tableView == self.ui.departuresTableView {
            flight = self.ui.departures[indexPath.row]
            cell.configureDeparture(with: flight)
        } else if tableView == self.ui.arrivalsTableView {
            flight = self.ui.arrivals[indexPath.row]
            cell.configureArrival(with: flight)
        } else {
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
