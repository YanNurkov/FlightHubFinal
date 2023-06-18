//
//  MainViewController.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit
import MapKit

protocol IMainView: AnyObject {
    var hasShownErrorAlert: Bool { get set }
    var suggestions: [AutocompleteResponse] { get set }
    func displayAlertStatusSave(with type: Alert)
    func parseAirportData(_ airports: [Airport]?)
    func updateAircraftAnnotations(_ aircrafts: [Aircraft])
    func reloadTable()
}

class MainViewController: UIViewController {
    var presenter: IMainViewPresenter?
    let ui = MainView()
    var aircraftAnnotations: [MKPointAnnotation] = []
    var hasShownErrorAlert = false
    var allAirports: [Airport] = []
    var suggestions: [AutocompleteResponse] = []
    var selectedSuggestion: AutocompleteResponse?
    var searchBar = UISearchBar()
    var timer: Timer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.ui)
        self.setupDelegates()
        self.showLocation()
        self.fetchAirportAndAirplaneData()
        self.ui.tableDataSource = self
        self.ui.tableViewDelegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    // MARK: - Actions
    
    @objc func searchButtonTapped() {
        if ui.isSearchVisible {
            self.hideSearchView()
        } else {
            self.showSearchView()
        }
    }
    
    @objc func favoritesButtonTapped() {
        self.presenter?.showFavoritesScreen()
    }
    
    @objc func showUserLocation() {
        self.showLocation()
    }
    
    // MARK: - Fucntions
    
    func reloadTable() {
        self.ui.tableView.reloadData()
    }
}

// MARK: - Extensions

private extension MainViewController {
    private func showLocation() {
        if self.ui.locationManager.authorizationStatus == .authorizedWhenInUse {
            self.ui.mapView.showsUserLocation = true
            if let userLocation = self.ui.mapView.userLocation.location {
                let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
                self.ui.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    private func showSearchView() {
        let screenWidth = UIScreen.main.bounds.width
        
        self.searchBar.delegate = self
        self.searchBar.frame = CGRect(x: view.bounds.width, y: 60, width: screenWidth, height: 50)
        self.searchBar.backgroundColor = .white
        self.searchBar.layer.cornerRadius = 50
        
        self.view.addSubview(self.searchBar)
        UIView.animate(withDuration: 0.3) {
            self.searchBar.frame.origin.x = self.view.bounds.width - screenWidth
        }
        self.ui.isSearchVisible = true
    }
    
    private func setupDelegates () {
        self.ui.locationDelegate = self
        self.ui.mapView.delegate = self
    }
    
    private func fetchAirportAndAirplaneData() {
        self.presenter?.getAirport()
        self.presenter?.getAirplane()
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { [weak self] (_) in
            self?.presenter?.getAirplane()
        }
    }
    
    private func hideSearchView() {
        guard let searchView = view.subviews.last else { return }
        UIView.animate(withDuration: 0.3, animations: {
            searchView.frame.origin.x = self.view.bounds.width
        }) { _ in
            searchView.removeFromSuperview()
        }
        self.ui.isSearchVisible = false
    }
    
    private func getCityNameFromLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (String?) -> Void) {
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

extension MainViewController: IMainView {
    func displayAlertStatusSave(with type: Alert) {
        AlertView.showAlertStatus(type: type, view: self)
    }
    
    func parseAirportData(_ airports: [Airport]?) {
        guard let airports = airports else {
            print("Invalid airport data")
            return
        }
        
        for airport in airports {
            let code = airport.code
            let name = airport.name
            let latitude = airport.coordinates.lat
            let longitude = airport.coordinates.lon
            
            let airportCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let airportAnnotation = AirportAnnotation()
            airportAnnotation.coordinate = airportCoordinate
            airportAnnotation.title = name
            airportAnnotation.subtitle = code
            
            self.ui.mapView.addAnnotation(airportAnnotation)
            self.allAirports.append(airport)
        }
    }
    
    func updateAircraftAnnotations(_ aircrafts: [Aircraft]) {
        self.ui.mapView.removeAnnotations(self.aircraftAnnotations)
        self.aircraftAnnotations.removeAll()
        for aircraft in aircrafts {
            let annotation = AircraftAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: aircraft.latitude, longitude: aircraft.longitude)
            if let flightNumber = aircraft.flightNumber {
                annotation.fullFlightNumber = aircraft.flightIATA ?? flightNumber
            } else {
                annotation.fullFlightNumber = aircraft.flightIATA ?? "Unknown"
            }
            
            annotation.aircraftICAO = aircraft.aircraftICAO ?? "Unknown"
            annotation.trueTrack = Double(aircraft.direction)
            annotation.regNumber = aircraft.regNumber ?? "Unknown"
            annotation.flag = aircraft.flag ?? ""
            annotation.altitude = aircraft.altitude
            annotation.direction = aircraft.direction
            annotation.speed = aircraft.speed
            annotation.verticalSpeed = aircraft.verticalSpeed ?? 0.0
            annotation.arrivalIATA = aircraft.arrivalIATA ?? ""
            annotation.airlineICAO = aircraft.airlineICAO ?? ""
            annotation.aircraftICAO = aircraft.aircraftICAO ?? ""
            annotation.flightICAO = aircraft.flightICAO ?? ""
            annotation.flightIATA = aircraft.flightIATA ?? ""
            annotation.departureICAO = aircraft.departureICAO ?? ""
            annotation.departureIATA = aircraft.departureIATA ?? ""
            annotation.airlineIATA = aircraft.airlineIATA ?? ""
            
            self.aircraftAnnotations.append(annotation)
        }
        self.ui.mapView.addAnnotations(self.aircraftAnnotations)
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchTextDidChange(searchText)
    }
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.ui.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
            self.ui.mapView.setRegion(region, animated: true)
            self.ui.locationManager.stopUpdatingLocation()
        }
    }
}

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let aircraftAnnotation = annotation as? AircraftAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AircraftAnnotation") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "AircraftAnnotation")
            annotationView.image = UIImage(named: "aircraft_icon")
            annotationView.canShowCallout = true
            
            let trueTrack = aircraftAnnotation.trueTrack
            let rotationAngle = trueTrack * .pi / 180.0
            annotationView.transform = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
            annotationView.calloutOffset = CGPoint(x: 0, y: -annotationView.bounds.size.height)
            
            annotationView.subviews.forEach { subview in
                if let label = subview as? UILabel {
                    label.removeFromSuperview()
                }
            }
            let flightNumberLabel = UILabel()
            flightNumberLabel.textColor = .white
            flightNumberLabel.textAlignment = .center
            flightNumberLabel.font = UIFont.systemFont(ofSize: 12)
            flightNumberLabel.text = aircraftAnnotation.fullFlightNumber
            flightNumberLabel.transform = CGAffineTransform(rotationAngle: CGFloat(-rotationAngle))
            flightNumberLabel.backgroundColor = .customLabelBlue
            flightNumberLabel.layer.cornerRadius = 5
            flightNumberLabel.layer.masksToBounds = true
            annotationView.addSubview(flightNumberLabel)
            flightNumberLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                flightNumberLabel.centerXAnchor.constraint(equalTo: annotationView.centerXAnchor),
                flightNumberLabel.topAnchor.constraint(equalTo: annotationView.bottomAnchor, constant: Layout.topAnchor)
            ])
            return annotationView
            
        } else if annotation is MKPointAnnotation {
            let iconSize = CGSize(width: Layout.iconSize, height: Layout.iconSize)
            let renderer = UIGraphicsImageRenderer(size: iconSize)
            let airportIconImage = renderer.image { _ in
                UIImage(named: "airport_icon")?.draw(in: CGRect(origin: .zero, size: iconSize))
            }
            
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AirportAnnotation") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "AirportAnnotation")
            annotationView.image = airportIconImage
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: 0, y: -annotationView.bounds.size.height)
            
            return annotationView
            
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation as? AircraftAnnotation {
            self.presenter?.showDetailAirplane(annotation: annotation, allAirports: allAirports)
            print(annotation)
        }  else if let annotation = view.annotation as? AirportAnnotation {
            self.presenter?.showAirportDetail(annotation: annotation)
        }
    }
    
    func moveMapToCoordinates(_ coordinates: CoordinatesCity) {
        let location = CLLocationCoordinate2D(latitude: coordinates.lat, longitude: coordinates.lon)
        self.ui.mapView.setCenter(location, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let suggestion = suggestions[indexPath.row]
        cell.textLabel?.text = "\(suggestion.name ?? "") \(suggestion.mainAirportName ?? "")"
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSuggestion = suggestions[indexPath.row]
        if let suggestion = selectedSuggestion {
            self.searchBar.text = "\(suggestion.name ?? "") \(suggestion.mainAirportName ?? "")"
            self.moveMapToCoordinates(suggestion.coordinates)
            self.ui.tableView.isHidden = true
            let annotation = AirportAnnotation()
            annotation.subtitle = suggestion.code
            annotation.title = "\(suggestion.mainAirportName ?? "") \nгород \(suggestion.name ?? "")"
            self.presenter?.showAirportDetail(annotation: annotation)
        }
    }
}

private extension MainViewController {
    enum Layout {
        static let topAnchor: CGFloat = 10
        static let iconSize: CGFloat = 20
    }
}
