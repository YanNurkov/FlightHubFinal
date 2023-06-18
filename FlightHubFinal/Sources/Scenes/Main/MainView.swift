//
//  MainView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit
import MapKit
import SnapKit

protocol IMainScreenView: AnyObject {
    var label: UILabel { get }
    var tableView: UITableView { get set }
    var tableDataSource: UITableViewDataSource? { get set }
    var tableViewDelegate: UITableViewDelegate? { get set }
}

// MARK: - Elements

final class MainView: UIView {
    var isSearchVisible = false
    var locationDelegate: CLLocationManagerDelegate?
    var mapViewDelegate: MKMapViewDelegate?
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.requestWhenInUseAuthorization()
        return location
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        label.text = "No Data Available"
        label.layer.cornerRadius = Layout.labelHeight/2
        label.layer.masksToBounds = true
        label.isHidden = true
        return label
    }()
    
    
    private lazy var locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.addTarget(nil, action: #selector(MainViewController.showUserLocation), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 0)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.addTarget(nil, action: #selector(MainViewController.searchButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.addTarget(nil, action: #selector(MainViewController.favoritesButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .white.withAlphaComponent(0.0)
        return tableView
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
    
    // MARK: - SetupView
    
    private func configureView() {
        self.addSubview(self.mapView)
        self.mapView.addSubview(self.label)
        self.mapView.addSubview(self.locationButton)
        self.mapView.addSubview(self.searchButton)
        self.mapView.addSubview(self.favoritesButton)
        self.mapView.addSubview(tableView)
    }
}

// MARK: - Extensions

extension MainView: IMainScreenView {
    var tableDataSource: UITableViewDataSource? {
        get {
            self.tableView.dataSource
        }
        set {
            self.tableView.dataSource = newValue
        }
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get {
            self.tableView.delegate
        }
        set {
            self.tableView.delegate = newValue
        }
    }
}

private extension MainView {
    private func makeConstraints() {
        self.label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Layout.labelTop)
            make.height.equalTo(Layout.labelHeight)
            make.width.equalTo(Layout.labelWidth)
        }
        
        self.mapView.snp.makeConstraints { make in
            make.top.right.bottom.left.equalTo(self)
        }
        
        self.searchButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Layout.searchButtonTop)
            make.height.width.equalTo(Layout.buttonWidthHeight)
            make.trailing.equalTo(self.snp.trailing).offset(Layout.buttonTrailing)
        }
        
        self.locationButton.snp.makeConstraints { make in
            make.top.equalTo(searchButton.snp.bottom).offset(Layout.buttonTop)
            make.height.width.equalTo(Layout.buttonWidthHeight)
            make.trailing.equalTo(self.snp.trailing).offset(Layout.buttonTrailing)
        }
        
        self.favoritesButton.snp.makeConstraints { make in
            make.top.equalTo(locationButton.snp.bottom).offset(Layout.buttonTop)
            make.height.width.equalTo(Layout.buttonWidthHeight)
            make.trailing.equalTo(self.snp.trailing).offset(Layout.buttonTrailing)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(0)
            make.top.equalToSuperview().offset(Layout.tableViewTop)
            make.bottom.equalToSuperview().offset(Layout.tableViewBottom)
        }
        
    }
}

private extension MainView {
    enum Layout {
        static let labelHeight: CGFloat = 35
        static let labelWidth: CGFloat = 200
        static let labelTop: CGFloat = 70
        static let searchButtonTop: CGFloat = 115
        static let buttonWidthHeight: CGFloat = 40
        static let buttonTop: CGFloat = 5
        static let buttonTrailing: CGFloat = -16
        static let tableViewTop: CGFloat = 110
        static let tableViewBottom: CGFloat = -500
    }
}

