//
//  AirPlaneViewController.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol IAirPlaneViewController: AnyObject {
    func updateAirlineName(string: String)
    func updateAirlineLogo(with data: Data)
}

class AirPlaneViewController: UIViewController, IAirPlaneViewController {
    
    var presenter: IAirPlanePresenter?
    let ui = AirPlaneView()
    var annotation = AircraftAnnotation()
    var allAirports: [Airport] = []
    var airlineIATA: String? {
        didSet {
            let airlineIATAstring = airlineIATA ?? ""
            presenter?.loadAirlineLogo(iataCode: airlineIATAstring)
            presenter?.loadAirlineData(iataCode: airlineIATAstring)
        }
    }
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.ui)
        self.congigAirplaneView()
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    // MARK: - Init
    
    init(annotation: AircraftAnnotation, allAirports: [Airport]) {
        super.init(nibName: nil, bundle: nil)
        self.annotation = annotation
        self.allAirports = allAirports
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func congigAirplaneView() {
        self.presenter?.loadData(annotation: annotation.fullFlightNumber, completion: { flightData in
            self.ui.planeModelInfo = self.annotation.aircraftICAO
            self.ui.planeRegNumberInfo = self.annotation.regNumber
            self.ui.speedInfo = String(self.annotation.speed)
            self.ui.altitudeInfo = String(self.annotation.altitude)
            self.ui.directionInfo = self.flightDirection(from: self.annotation.direction)
            self.ui.departureAirportCode = self.annotation.departureIATA
            self.airlineIATA = self.annotation.airlineIATA
            self.ui.numberOfFlight = self.annotation.fullFlightNumber
            
            self.ui.departureCodeAirportLabel.text = flightData?.response.departureIATA
            self.ui.arrivalCodeAirportLabel.text = flightData?.response.arrivalIATA
            self.ui.departureTimeLabel.text = flightData?.response.departureTime
            self.ui.arrivalTimeLabel.text = flightData?.response.arrivalTime
            self.ui.manufacturerPlaneLabel.text = flightData?.response.manufacturer
            self.ui.infoAboutNameLabel.text = flightData?.response.model
            self.ui.yearsAircraftLabel.text = "Возраст самолета \(String(flightData?.response.age ?? 0))"
            self.ui.yearBuildAircraftLabel.text = "Построен в \(String(flightData?.response.built ?? 0)) г."
            let duration = self.calculateDuration(departureTime: flightData?.response.departureTime, arrivalTime: flightData?.response.arrivalTime)
            self.ui.timeOfFlightLabel.text = duration
            if duration == "" {
                self.ui.timeOfFlightLabel.isHidden = true
            }
            self.ui.arrivalAirportCode = flightData?.response.arrivalIATA ?? ""
            self.ui.departureAirportCode = flightData?.response.departureIATA ?? ""
            
            
            
            
            if let arrivalCityCode = self.findCityCodeByAirportCode(flightData?.response.arrivalIATA ?? "") {
                self.presenter?.fetchCityDetails(city: arrivalCityCode) { cityResponse in
                    if let arrivalCity = cityResponse?.response.first {
                        if let departureCityCode = self.findCityCodeByAirportCode(flightData?.response.departureIATA ?? "") {
                            self.presenter?.fetchCityDetails(city: departureCityCode) { cityResponse in
                                if let departureCity = cityResponse?.response.first {
                                    let itineraryText = "\(departureCity.cityName) - \(arrivalCity.cityName)"
                                    self.ui.itineraryLabel.text = itineraryText
                                    self.ui.itineraryLabel.textAlignment = .center
                                    self.ui.flagDepartureImage.image = UIImage(named: departureCity.countryCode.lowercased())
                                    self.ui.flagArrivalImage.image = UIImage(named: arrivalCity.countryCode.lowercased())
                                    self.ui.departureCityLabel.text = departureCity.cityName
                                    self.ui.arrivalCityLabel.text = arrivalCity.cityName
                                } else {
                                    print("Unable to fetch departure city details")
                                }
                            }
                        } else {
                            print("Departure airport code not found")
                        }
                    } else {
                        print("Unable to fetch arrival city details")
                    }
                }
            } else {
                print("Arrival airport code not found")
            }
        })
    }
    
    private func flightDirection(from bearing: Int) -> String {
        let directions = ["Север", "Северо-Восток", "Северо-Восток", "Северо-Восток", "Восток", "Юго-Восток", "Юго-Восток", "Юго-Восток", "Юг", "Юго-Запад", "Юго-Запад", "Юго-Запад", "Запад", "Северо-Запад", "Северо-Запад", "Северо-Запад"]
        
        let index = Int((Double(bearing) / 22.5) + 0.5) % 16
        return directions[index]
    }
    
    private func findCityCodeByAirportCode(_ airportCode: String) -> String? {
        if let airport = allAirports.first(where: { $0.code == airportCode }) {
            return airport.cityCode
        } else {
            return nil
        }
    }
    
    private func calculateDuration(departureTime: String?, arrivalTime: String?) -> String {
        guard let departureTime = departureTime, let arrivalTime = arrivalTime else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let departureDate = dateFormatter.date(from: departureTime),
              let arrivalDate = dateFormatter.date(from: arrivalTime) else {
            return ""
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: departureDate, to: arrivalDate)
        
        if let hours = components.hour, let minutes = components.minute {
            return " \(hours)ч \(minutes)м "
        } else {
            return ""
        }
    }
    
    func updateAirlineName(string: String) {
        self.ui.airlineNameLabel.text = string
    }
    
    func updateAirlineLogo(with data: Data) {
            self.ui.airlineLogoImage.image = UIImage(data: data)
            self.ui.airlineLogoSecondImage.image = UIImage(data: data)
        }
}
