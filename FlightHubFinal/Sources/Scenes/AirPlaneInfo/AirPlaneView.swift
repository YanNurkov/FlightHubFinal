//
//  AirPlaneView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol IAirPlaneView: AnyObject {
    var numberOfFlightData: String? { get set }
}

final class AirPlaneView: UIView, IAirPlaneView {
    var arrivalAirportCode = "airportCodeArrival"
    var departureAirportCode = "DEP"
    var numberOfFlight = ""
    
    var planeModelInfo: String? {
        didSet {
            let modifiedAircraftType = planeModelInfo?.appendManufacturerName()
            planeModelInfoLabel.text = modifiedAircraftType
        }
    }
    
    var planeRegNumberInfo: String? {
        didSet {
            planeRegNumberInfoLabel.text = "Рег. номер " + (planeRegNumberInfo ?? "Не известен")
        }
    }
    
    var speedInfo: String? {
        didSet {
            speedInfoLabel.text = speedInfo
        }
    }
    
    var altitudeInfo: String? {
        didSet {
            altitudeInfoLabel.text = altitudeInfo
        }
    }
    
    var directionInfo: String? {
        didSet {
            directionInfoLabel.text = directionInfo
        }
    }
    
    var airportCodeArrival : String? {
        didSet {
            arrivalAirportCode = airportCodeArrival ?? ""
        }
    }
    
    var departureCodeArrival : String? {
        didSet {
            departureAirportCode = departureCodeArrival ?? ""
        }
    }
    
    
    var numberOfFlightData: String? {
        didSet {
            numberOfFlight = numberOfFlightData ?? ""
        }
    }
    
    var airlineIATA: String? {
        didSet {
            let airlineIATAstring = airlineIATA ?? ""
            if let url = URL(string: "http://pics.avs.io/100/100/\(airlineIATAstring).png") {
                print(" !!!!!!!\(url)")
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.airlineLogoImage.image = UIImage(data: data)
                            self.airlineLogoSecondImage.image = UIImage(data: data)
                        }
                    }
                }
            }
            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
            let urlString = "https://airlabs.co/api/v9/airlines?iata_code=\(airlineIATAstring)&api_key=\(apiKey)"
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let airlineResponse = try decoder.decode(AirlineResponse.self, from: data)
                            if let airline = airlineResponse.response.first {
                                DispatchQueue.main.async {
                                    self.airlineNameLabel.text = ("\(airline.name) • \(self.numberOfFlight)")
                                }
                            }
                        } catch {
                            print("Error decoding airline data: \(error)")
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    // MARK: - Elements
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.97)
        view.alpha = 0.983
        return view
    }()
    
    private lazy var planeModelInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 21)
        return label
    }()
    
    
    private lazy var planePhotoImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.image = UIImage(named: "airplane")
        return image
    }()
    
    
    private lazy var planeRegNumberInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    private lazy var speedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Скорость"
        label.font =  UIFont.customFont(type: .montserratAlternates, size: 18)
        return label
    }()
    
    private lazy var altitudeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Высота"
        label.font =  UIFont.customFont(type: .montserratAlternates, size: 18)
        return label
    }()
    
    private lazy var passLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.text = "Направление"
        label.font = UIFont.customFont(type: .montserratAlternates, size: 18)
        return label
    }()
    
    private lazy var speedInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 30)
        return label
    }()
    
    private lazy var speedInfoMileLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.text = "миль/ч"
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    private lazy var altitudeInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 30)
        return label
    }()
    
    private lazy var directionInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .right
        return label
    }()
    
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var itineraryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var flagDepartureImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    lazy var flagArrivalImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var airlineLogoImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var airlineNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var departureCodeAirportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 35)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var arrivalCodeAirportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 35)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var timeOfFlightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        label.backgroundColor = UIColor.gray
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    lazy var departureCityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var arrivalCityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .right
        return label
    }()
    
    private lazy var whiteSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var airlineLogoSecondImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    lazy var manufacturerPlaneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var infoAboutNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var yearsAircraftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    lazy var yearBuildAircraftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 15)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.configureView()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.addSubview(grayView)
        grayView.addSubview(planeModelInfoLabel)
        grayView.addSubview(planePhotoImage)
        grayView.addSubview(planeRegNumberInfoLabel)
        grayView.addSubview(speedLabel)
        grayView.addSubview(altitudeLabel)
        grayView.addSubview(passLabel)
        grayView.addSubview(speedInfoLabel)
        grayView.addSubview(altitudeInfoLabel)
        grayView.addSubview(directionInfoLabel)
        grayView.addSubview(speedInfoMileLabel)
        grayView.addSubview(whiteView)
        whiteView.addSubview(itineraryLabel)
        whiteView.addSubview(flagDepartureImage)
        whiteView.addSubview(flagArrivalImage)
        whiteView.addSubview(airlineLogoImage)
        whiteView.addSubview(airlineNameLabel)
        whiteView.addSubview(arrivalCityLabel)
        whiteView.addSubview(departureCodeAirportLabel)
        whiteView.addSubview(arrivalCodeAirportLabel)
        whiteView.addSubview(timeOfFlightLabel)
        whiteView.addSubview(departureCityLabel)
        whiteView.addSubview(arrivalCityLabel)
        whiteView.addSubview(departureTimeLabel)
        whiteView.addSubview(arrivalTimeLabel)
        grayView.addSubview(whiteSecondView)
        whiteSecondView.addSubview(airlineLogoSecondImage)
        whiteSecondView.addSubview(manufacturerPlaneLabel)
        whiteSecondView.addSubview(infoAboutNameLabel)
        whiteSecondView.addSubview(yearsAircraftLabel)
        whiteSecondView.addSubview(yearBuildAircraftLabel)
        
    }
}

// MARK: - Extensions

private extension AirPlaneView {
    private func makeConstraints() {
        self.grayView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(15)
        }
        self.planePhotoImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(-16)
            make.height.equalTo(100)
            make.width.equalTo(170)
        }
        self.planeModelInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.planePhotoImage.snp.trailing).offset(16)
            make.centerY.equalTo(planePhotoImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(23)
        }
        
        self.planeRegNumberInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.planePhotoImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            make.bottom.equalTo(self.planePhotoImage.snp.bottom).offset(-15)
        }
        
        self.speedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        
        self.altitudeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(20)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        self.passLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(135)
        }
        
        self.speedInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.speedLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        self.speedInfoMileLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.speedInfoLabel.snp.trailing).offset(5)
            make.bottom.equalTo(self.speedInfoLabel.snp.bottom)
            make.height.equalTo(13)
        }
        
        self.altitudeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.altitudeLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        self.directionInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(passLabel.snp.leading)
            make.top.equalTo(self.passLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        self.whiteView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.arrivalTimeLabel.snp.bottom).offset(16)
            make.top.equalTo(directionInfoLabel.snp.bottom).offset(16)
        }
        
        self.itineraryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteView.snp.centerX)
            make.top.equalTo(whiteView.snp.top).offset(16)
            make.height.equalTo(22)
        }
        
        self.flagDepartureImage.snp.makeConstraints { make in
            make.leading.equalTo(whiteView.snp.leading).offset(16)
            make.height.width.equalTo(22)
            make.centerY.equalTo(itineraryLabel.snp.centerY)
        }
        
        self.flagArrivalImage.snp.makeConstraints { make in
            make.height.width.equalTo(22)
            make.centerY.equalTo(itineraryLabel.snp.centerY)
            make.trailing.equalTo(whiteView.snp.trailing).inset(16)
        }
        
        self.airlineLogoImage.snp.makeConstraints { make in
            make.leading.equalTo(whiteView.snp.leading).offset(16)
            make.top.equalTo(flagDepartureImage.snp.bottom).offset(16)
            make.width.height.equalTo(40)
        }
        
        self.airlineNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(airlineLogoImage.snp.trailing).offset(16)
            make.height.equalTo(14)
            make.centerY.equalTo(airlineLogoImage.snp.centerY)
        }
        
        self.departureCodeAirportLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(airlineNameLabel.snp.bottom).offset(16)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
        
        self.arrivalCodeAirportLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(airlineNameLabel.snp.bottom).offset(16)
            make.height.equalTo(35)
            make.width.equalTo(60)
        }
        
        self.timeOfFlightLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(40)
            make.top.equalTo(airlineNameLabel.snp.bottom).offset(16)
            make.centerX.equalTo(whiteView.snp.centerX)
        }
        
        self.departureCityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.arrivalCityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.arrivalCityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.departureTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(departureCityLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.arrivalTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(arrivalCityLabel.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.whiteSecondView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(whiteView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
        self.airlineLogoSecondImage.snp.makeConstraints { make in
            make.centerX.equalTo(whiteSecondView.snp.centerX)
            make.width.height.equalTo(100)
        }
        
        self.manufacturerPlaneLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteSecondView.snp.centerX)
            make.top.equalTo(airlineLogoSecondImage.snp.bottom)
        }
        
        self.infoAboutNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteSecondView.snp.centerX)
            make.top.equalTo(manufacturerPlaneLabel.snp.bottom).offset(5)
        }
        
        self.yearsAircraftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteSecondView.snp.centerX)
            make.top.equalTo(infoAboutNameLabel.snp.bottom).offset(5)
        }
        
        self.yearBuildAircraftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(whiteSecondView.snp.centerX)
            make.top.equalTo(yearsAircraftLabel.snp.bottom).offset(5)
        }
    }
}

