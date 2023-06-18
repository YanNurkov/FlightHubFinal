//
//  FlightCell.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation
import UIKit

class FlightCell: UITableViewCell {
    static let identifier = "FlightCell"
    weak var delegate: AirportInfoPresenter?
    let data = DataLoader()
    
    private lazy var flightNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 13)
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 13)
        label.numberOfLines = 2
        return label
    }()
    
    
    private lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.customFont(type: .montserratAlternatesThin, size: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.flightNumberLabel)
        self.contentView.addSubview(self.departureLabel)
        self.contentView.addSubview(self.arrivalLabel)
        self.contentView.addSubview(self.cityLabel)
        self.makeConstraints()
    }
    
    
    func makeConstraints() {
        self.departureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(5)
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        self.cityLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.departureLabel.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(13)
        }
        
        self.arrivalLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(13)
        }
        
        self.flightNumberLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.departureLabel.snp.trailing).offset(16)
            make.top.equalTo(self.cityLabel.snp.bottom).offset(10)
            make.height.equalTo(13)
        }
    }
    
    func configureDeparture(with flight: Flight) {
        
        self.flightNumberLabel.text = flight.flightIATA
        let formattedTime = formatTimeComparison(depTime: extractTime(from: flight.departureTime ?? "") ?? "", depEstimated: extractTime(from: flight.departureEstimated ?? "") ?? "")
        self.departureLabel.attributedText = formattedTime
        
        
        self.arrivalLabel.text = "\(flight.arrivalIATA ?? "")"
        
        self.data.fetchCityDetails(cityCode: flight.arrivalIATA ?? "") { cityResponse in
            if let departureCity = cityResponse?.response.first {
                self.cityLabel.text = departureCity.cityName
            } else {
                print("Unable to fetch departure city details")
            }
        }
    }
    
    func configureArrival(with flight: Flight) {
        
        self.flightNumberLabel.text = flight.flightIATA
        let formattedTime = formatTimeComparison(depTime: extractTime(from: flight.departureTime ?? "") ?? "", depEstimated: extractTime(from: flight.departureEstimated ?? "") ?? "")
        self.departureLabel.attributedText = formattedTime
        
        
        self.arrivalLabel.text = "\(flight.departureIATA ?? "")"
        
        self.data.fetchCityDetails(cityCode: flight.departureIATA ?? "") { cityResponse in
            if let departureCity = cityResponse?.response.first {
                self.cityLabel.text = departureCity.cityName
                
            } else {
                print("Unable to fetch departure city details")
            }
        }
    }
    
    func extractTime(from dateTimeString: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = inputDateFormatter.date(from: dateTimeString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm"
            return outputDateFormatter.string(from: date)
        }
        
        return nil
    }
    
    func formatTimeComparison(depTime: String, depEstimated: String) -> NSAttributedString {
        if depTime == depEstimated || depEstimated.isEmpty {
            return NSAttributedString(string: depTime)
        } else {
            let formattedTime = "\(depTime) \n\(depEstimated)"
            
            let attributedString = NSMutableAttributedString(string: formattedTime)
            let range = (formattedTime as NSString).range(of: depTime)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            
            return attributedString
        }
    }
}
