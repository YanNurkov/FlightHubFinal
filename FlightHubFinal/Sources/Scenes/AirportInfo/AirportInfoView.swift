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
            self.airportCode = self.airportCodeData ?? ""
            self.departureLabel.text = "\u{1F6EB} Вылеты из \(self.airportCode)"
            self.arrivalLabel.text = "\u{1F6EC} Прилеты из \(self.airportCode)"
        }
    }
    var airportNameData : String? {
        didSet {
            self.airportNameLabel.text = self.airportNameData ?? ""
        }
    }
    
    // MARK: - Elements
    
    private lazy var airportNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.customFont(type: .montserratAlternatesBold, size: 20)
        label.numberOfLines = 2
        return label
    }()
    
    
    private lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    private lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(type: .montserratAlternates, size: 13)
        return label
    }()
    
    lazy var departuresTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        tableView.layer.cornerRadius = 10
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    lazy var arrivalsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(nil, action: #selector(AirportInfoViewController.saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .customBackgroundGray
        self.configureView()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(self.airportNameLabel)
        self.addSubview(self.departuresTableView)
        self.addSubview(self.arrivalsTableView)
        self.addSubview(self.departureLabel)
        self.addSubview(self.arrivalLabel)
        self.addSubview(self.saveButton)
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
            make.top.equalToSuperview().offset(Layout.standartTop)
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
        }
        
        self.departuresTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.departureLabel.snp.bottom).offset(Layout.standartTop)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        self.arrivalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.departuresTableView.snp.bottom).offset(Layout.arrivalLabelTop)
            make.height.equalTo(Layout.standartHeight)
        }
        
        self.arrivalsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalTo(self.arrivalLabel.snp.bottom).offset(Layout.standartTop)
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        self.departureLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Layout.standartLeading)
            make.top.equalTo(self.airportNameLabel.snp.bottom).offset(Layout.standartTop)
            make.height.equalTo(Layout.standartHeight)
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(Layout.standartTrailing)
            make.top.equalToSuperview().offset(Layout.standartTop)
            make.height.equalTo(Layout.saveButtonHeight)
        }
    }
}

private extension AirportInfoView {
    enum Layout {
        static let standartLeading: CGFloat = 16
        static let standartTrailing: CGFloat = -16
        static let standartTop: CGFloat = 16
        static let standartHeight: CGFloat = 14
        static let arrivalLabelTop: CGFloat = 26
        static let saveButtonHeight: CGFloat = 30
    }
}
