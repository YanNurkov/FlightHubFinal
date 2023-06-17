//
//  AirportInfoView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol IAirportInfoView: AnyObject {
    var airportCode: String { get }
    var departures: [Flight] { get set }
    var arrivals: [Flight] { get set }
    var departuresTableView: UITableView { get set }
    var arrivalsTableView: UITableView { get set }
    
    var departureTableDataSource: UITableViewDataSource? { get set }
    var departureTableViewDelegate: UITableViewDelegate? { get set }
    var arrivalTableDataSource: UITableViewDataSource? { get set }
    var arrivalTableViewDelegate: UITableViewDelegate? { get set }
}

final class AirportInfoView: UIView {
    var airportCode: String = ""
    var departures: [Flight] = []
    var arrivals: [Flight] = []
    var airportCodeData : String? {
        didSet {
            airportCode = airportCodeData ?? ""
            departureLabel.text = "\u{1F6EB} Вылеты из \(airportCode)"
            arrivalLabel.text = "\u{1F6EC} Прилеты из \(airportCode)"
        }
    }
    var airportNameData : String? {
        didSet {
            airportNameLabel.text = airportNameData ?? ""
        }
    }
    
    // MARK: - Elements
    
    private let airportNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    
    private let departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    private let arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    var departuresTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    var arrivalsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(nil, action: #selector(AirportInfoViewController.saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.983)
        self.configureView()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(airportNameLabel)
        self.addSubview(departuresTableView)
        self.addSubview(arrivalsTableView)
        self.addSubview(departureLabel)
        self.addSubview(arrivalLabel)
        self.addSubview(saveButton)
    }
}

// MARK: - Extensions

extension AirportInfoView: IAirportInfoView {
    var departureTableDataSource: UITableViewDataSource? {
        get {
            self.departuresTableView.dataSource
        }
        set {
            self.departuresTableView.dataSource = newValue
        }
    }
    
    var departureTableViewDelegate: UITableViewDelegate? {
        get {
            self.departuresTableView.delegate
        }
        set {
            self.departuresTableView.delegate = newValue
        }
    }
    
    var arrivalTableDataSource: UITableViewDataSource? {
        get {
            self.arrivalsTableView.dataSource
        }
        set {
            self.arrivalsTableView.dataSource = newValue
        }
    }
    
    var arrivalTableViewDelegate: UITableViewDelegate? {
        get {
            self.arrivalsTableView.delegate
        }
        set {
            self.arrivalsTableView.delegate = newValue
        }
    }
}

private extension AirportInfoView {
    private func makeConstraints() {
        self.airportNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        self.departuresTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(departureLabel.snp.bottom).offset(16)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        self.arrivalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(departuresTableView.snp.bottom).offset(26)
            make.height.equalTo(14)
        }
        
        self.arrivalsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(arrivalLabel.snp.bottom).offset(16)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        self.departureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(airportNameLabel.snp.bottom).offset(16)
            make.height.equalTo(14)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
        }
    }
}
