//
//  AirPlaneView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol IAirPlaneView: AnyObject {
    var numberOfFlight: String { get set }
}

final class AirPlaneView: UIView, IAirPlaneView {
    var arrivalAirportCode = "airportCodeArrival"
    var departureAirportCode = "airportCodeDeparture"
    var numberOfFlight = ""
    
    var planeModelInfo: String? {
        didSet {
            let modifiedAircraftType = planeModelInfo?.appendManufacturerName()
            self.planeModelInfoLabel.text = modifiedAircraftType
        }
    }
    
    var planeRegNumberInfo: String? {
        didSet {
            self.planeRegNumberInfoLabel.text = "Рег. номер " + (self.planeRegNumberInfo ?? "Не известен")
        }
    }
    
    var speedInfo: String? {
        didSet {
            self.speedInfoLabel.text = self.speedInfo
        }
    }
    
    var altitudeInfo: String? {
        didSet {
            self.altitudeInfoLabel.text = self.altitudeInfo
        }
    }
    
    var directionInfo: String? {
        didSet {
            self.directionInfoLabel.text = self.directionInfo
        }
    }
    
    var airportCodeArrival : String? {
        didSet {
            self.arrivalAirportCode = self.airportCodeArrival ?? ""
        }
    }
    
    var departureCodeArrival : String? {
        didSet {
            self.departureAirportCode = self.departureCodeArrival ?? ""
        }
    }
    
    
    var numberOfFlightData: String? {
        didSet {
            self.numberOfFlight = self.numberOfFlightData ?? ""
        }
    }
    
//    var airlineIATA: String? {
//        didSet {
//            let airlineIATAstring = airlineIATA ?? ""
//
//            if let url = URL(string: "http://pics.avs.io/100/100/\(airlineIATAstring).png") {
//                print(" !!!!!!!\(url)")
//                DispatchQueue.global().async {
//                    if let data = try? Data(contentsOf: url) {
//                        DispatchQueue.main.async {
//                            self.airlineLogoImage.image = UIImage(data: data)
//                            self.airlineLogoSecondImage.image = UIImage(data: data)
//                        }
//                    }
//                }
//            }
////            let apiKey = retrieveAPIKeyFromKeychain() ?? ""
////            let urlString = "https://airlabs.co/api/v9/airlines?iata_code=\(airlineIATAstring)&api_key=\(apiKey)"
//            presenter?.loadAirlineData(iataCode: airlineIATAstring)
////            if let url = URL(string: urlString) {
////                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
////                    if let error = error {
////                        print("Error: \(error)")
////                    } else if let data = data {
////                        do {
////                            let decoder = JSONDecoder()
////                            let airlineResponse = try decoder.decode(AirlineResponse.self, from: data)
////                            if let airline = airlineResponse.response.first {
////                                DispatchQueue.main.async {
////                                    self.airlineNameLabel.text = ("\(airline.name) • \(self.numberOfFlight)")
////                                }
////                            }
////                        } catch {
////                            print("Error decoding airline data: \(error)")
////                        }
////                    }
////                }
////                task.resume()
////            }
//        }
//    }
    
    // MARK: - Elements
    
    private lazy var grayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.backgroundColor = .customBackgroundGray
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
    
     lazy var airlineLogoImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
     lazy var airlineNameLabel: UILabel = {
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
    
     lazy var airlineLogoSecondImage: UIImageView = {
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
        self.addSubview(self.grayView)
        self.grayView.addSubview(self.planeModelInfoLabel)
        self.grayView.addSubview(self.planePhotoImage)
        self.grayView.addSubview(self.planeRegNumberInfoLabel)
        self.grayView.addSubview(self.speedLabel)
        self.grayView.addSubview(self.altitudeLabel)
        self.grayView.addSubview(self.passLabel)
        self.grayView.addSubview(self.speedInfoLabel)
        self.grayView.addSubview(self.altitudeInfoLabel)
        self.grayView.addSubview(self.directionInfoLabel)
        self.grayView.addSubview(self.speedInfoMileLabel)
        self.grayView.addSubview(self.whiteView)
        self.whiteView.addSubview(self.itineraryLabel)
        self.whiteView.addSubview(self.flagDepartureImage)
        self.whiteView.addSubview(self.flagArrivalImage)
        self.whiteView.addSubview(self.airlineLogoImage)
        self.whiteView.addSubview(self.airlineNameLabel)
        self.whiteView.addSubview(self.arrivalCityLabel)
        self.whiteView.addSubview(self.departureCodeAirportLabel)
        self.whiteView.addSubview(self.arrivalCodeAirportLabel)
        self.whiteView.addSubview(self.timeOfFlightLabel)
        self.whiteView.addSubview(self.departureCityLabel)
        self.whiteView.addSubview(self.arrivalCityLabel)
        self.whiteView.addSubview(self.departureTimeLabel)
        self.whiteView.addSubview(self.arrivalTimeLabel)
        self.grayView.addSubview(self.whiteSecondView)
        self.whiteSecondView.addSubview(self.airlineLogoSecondImage)
        self.whiteSecondView.addSubview(self.manufacturerPlaneLabel)
        self.whiteSecondView.addSubview(self.infoAboutNameLabel)
        self.whiteSecondView.addSubview(self.yearsAircraftLabel)
        self.whiteSecondView.addSubview(self.yearBuildAircraftLabel)
    }
}

// MARK: - Extensions

private extension AirPlaneView {
    private func makeConstraints() {
        self.grayView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.snp.top).offset(Layout.grayViewTop)
        }
        self.planePhotoImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalToSuperview().offset(Layout.planePhotoImageTop)
            make.height.equalTo(Layout.planePhotoImageHeight)
            make.width.equalTo(Layout.planePhotoImageWidth)
        }
        self.planeModelInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.planePhotoImage.snp.trailing).offset(Layout.standartLeading)
            make.centerY.equalTo(self.planePhotoImage.snp.centerY)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.height.equalTo(Layout.planeModelInfoLabelHeight)
        }
        
        self.planeRegNumberInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.planePhotoImage.snp.trailing).offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.height.equalTo(Layout.planeRegNumberInfoLabelHeight)
            make.bottom.equalTo(self.planePhotoImage.snp.bottom).offset(Layout.planeRegNumberInfoLabelBottom)
        }
        
        self.speedLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(Layout.speedAltitudaPass)
            make.height.equalTo(Layout.speedAltitudaPass)
        }
        
        self.altitudeLabel.snp.makeConstraints { make in
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(Layout.speedAltitudaPass)
            make.height.equalTo(Layout.speedAltitudaPass)
            make.centerX.equalToSuperview()
        }
        
        self.passLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.planePhotoImage.snp.bottom).offset(Layout.speedAltitudaPass)
            make.height.equalTo(Layout.speedAltitudaPass)
            make.width.equalTo(Layout.passLabelWidht)
        }
        
        self.speedInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.speedLabel.snp.bottom).offset(Layout.topOffset)
            make.height.equalTo(Layout.speedInfoLabelHeight)
        }
        
        self.speedInfoMileLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.speedInfoLabel.snp.trailing).offset(Layout.infoTop)
            make.bottom.equalTo(self.speedInfoLabel.snp.bottom).offset(Layout.speedInfoMileLabelBottom)
            make.height.equalTo(Layout.speedInfoMileLabelHeight)
        }
        
        self.altitudeInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(self.altitudeLabel.snp.bottom).offset(Layout.topOffset)
            make.height.equalTo(Layout.directionInfoLabelHeight)
            make.centerX.equalToSuperview()
        }
        
        self.directionInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.passLabel.snp.leading)
            make.top.equalTo(self.passLabel.snp.bottom).offset(Layout.topOffset)
            make.height.equalTo(Layout.directionInfoLabelHeight)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
        }
        
        self.whiteView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.bottom.equalTo(self.arrivalTimeLabel.snp.bottom).offset(Layout.whiteViewTopBottom)
            make.top.equalTo(self.directionInfoLabel.snp.bottom).offset(Layout.whiteViewTopBottom)
        }
        
        self.itineraryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteView.snp.centerX)
            make.top.equalTo(self.whiteView.snp.top).offset(Layout.standartTop)
            make.height.equalTo(Layout.flagWidht)
        }
        
        self.flagDepartureImage.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).offset(Layout.standartLeading)
            make.height.width.equalTo(Layout.flagWidht)
            make.centerY.equalTo(self.itineraryLabel.snp.centerY)
        }
        
        self.flagArrivalImage.snp.makeConstraints { make in
            make.height.width.equalTo(Layout.flagWidht)
            make.centerY.equalTo(self.itineraryLabel.snp.centerY)
            make.trailing.equalTo(self.whiteView.snp.trailing).inset(Layout.standartLeading)
        }
        
        self.airlineLogoImage.snp.makeConstraints { make in
            make.leading.equalTo(self.whiteView.snp.leading).offset(Layout.standartLeading)
            make.top.equalTo(self.flagDepartureImage.snp.bottom).offset(Layout.standartTop)
            make.width.height.equalTo(Layout.airlineLogoImageWidhtHeight)
        }
        
        self.airlineNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.airlineLogoImage.snp.trailing).offset(Layout.standartLeading)
            make.height.equalTo(Layout.airlineNameLabelHeight)
            make.centerY.equalTo(self.airlineLogoImage.snp.centerY)
        }
        
        self.departureCodeAirportLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.airlineNameLabel.snp.bottom).offset(Layout.standartTop)
            make.height.equalTo(Layout.departureCodeAirportLabelHeight)
            make.width.equalTo(Layout.departureCodeAirportLabelWidht)
        }
        
        self.arrivalCodeAirportLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.airlineNameLabel.snp.bottom).offset(Layout.standartTop)
            make.height.equalTo(Layout.departureCodeAirportLabelHeight)
            make.width.equalTo(Layout.departureCodeAirportLabelWidht)
        }
        
        self.timeOfFlightLabel.snp.makeConstraints { make in
            make.height.equalTo(Layout.timeCityHeight)
            make.width.equalTo(Layout.timeOfFlightLabelWidht)
            make.top.equalTo(self.airlineNameLabel.snp.bottom).offset(Layout.standartTop)
            make.centerX.equalTo(self.whiteView.snp.centerX)
        }
        
        self.departureCityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(Layout.timeCityHeight)
        }
        
        self.arrivalCityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(Layout.timeCityHeight)
        }
        
        self.arrivalCityLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.departureCodeAirportLabel.snp.bottom)
            make.height.equalTo(Layout.timeCityHeight)
        }
        
        self.departureTimeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.departureCityLabel.snp.bottom)
            make.height.equalTo(Layout.timeCityHeight)
        }
        
        self.arrivalTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.arrivalCityLabel.snp.bottom)
            make.height.equalTo(Layout.timeCityHeight)
        }
        
        self.whiteSecondView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.whiteView.snp.bottom).offset(Layout.standartTop)
            make.bottom.equalToSuperview()
        }
        
        self.airlineLogoSecondImage.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteSecondView.snp.centerX)
            make.width.height.equalTo(Layout.airlineLogoSecondImageWidhtHeight)
        }
        
        self.manufacturerPlaneLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteSecondView.snp.centerX)
            make.top.equalTo(self.airlineLogoSecondImage.snp.bottom)
        }
        
        self.infoAboutNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteSecondView.snp.centerX)
            make.top.equalTo(self.manufacturerPlaneLabel.snp.bottom).offset(Layout.infoTop)
        }
        
        self.yearsAircraftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteSecondView.snp.centerX)
            make.top.equalTo(self.infoAboutNameLabel.snp.bottom).offset(Layout.infoTop)
        }
        
        self.yearBuildAircraftLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.whiteSecondView.snp.centerX)
            make.top.equalTo(self.yearsAircraftLabel.snp.bottom).offset(Layout.infoTop)
        }
    }
}

private extension AirPlaneView {
    enum Layout {
        static let standartLeading: CGFloat = 16
        static let standartTrailing: CGFloat = -16
        static let standartTop: CGFloat = 16
        static let grayViewTop: CGFloat = 15
        static let planePhotoImageTop: CGFloat = -16
        static let planePhotoImageHeight: CGFloat = 100
        static let planePhotoImageWidth: CGFloat = 170
        static let planeModelInfoLabelHeight: CGFloat = 23
        static let planeRegNumberInfoLabelHeight: CGFloat = 20
        static let speedAltitudaPass: CGFloat = 20
        static let passLabelWidht: CGFloat = 135
        static let planeRegNumberInfoLabelBottom: CGFloat = -15
        static let infoTop: CGFloat = 5
        static let timeCityHeight: CGFloat = 20
        static let topOffset: CGFloat = 10
        static let speedInfoLabelHeight: CGFloat = 30
        static let airlineLogoSecondImageWidhtHeight: CGFloat = 100
        static let departureCodeAirportLabelWidht: CGFloat = 60
        static let departureCodeAirportLabelHeight: CGFloat = 35
        static let timeOfFlightLabelWidht: CGFloat = 40
        static let flagWidht: CGFloat = 22
        static let airlineNameLabelHeight: CGFloat = 14
        static let whiteViewTopBottom: CGFloat = 16
        static let directionInfoLabelHeight: CGFloat = 30
        static let speedInfoMileLabelHeight: CGFloat = 13
        static let airlineLogoImageWidhtHeight: CGFloat = 40
        static let speedInfoMileLabelBottom: CGFloat = -3
    }
}
