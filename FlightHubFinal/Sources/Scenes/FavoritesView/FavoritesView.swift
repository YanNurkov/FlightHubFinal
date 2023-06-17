//
//  FavoritesView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol IFavoritesView: AnyObject {
    var tableDataSource: UITableViewDataSource? { get set }
    var tableViewDelegate: UITableViewDelegate? { get set }
}

final class FavoritesView: UIView {
    
    // MARK: - Elements
    
    private lazy var topLabel: UILabel = {
         let obj = UILabel()
           obj.text = "Избранные аэропорты"
           obj.font = UIFont.customFont(type: .montserratAlternatesBold, size: 25)
           return obj
       }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.layer.cornerRadius = 10
        return tableView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.configureView()
        self.makeConstraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor =  UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.97)
        self.addSubview(tableView)
        self.addSubview(topLabel)
    }
}

// MARK: - Extensions

private extension FavoritesView {
    private func makeConstraints() {
           topLabel.snp.makeConstraints { make in
               make.top.equalTo(self.snp.top).offset(16)
               make.leading.equalTo(self.snp.leading).offset(16)
               make.trailing.equalTo(self.snp.trailing).offset(-16)
               make.height.equalTo(25)
           }
           
           tableView.snp.makeConstraints { make in
               make.top.equalTo(topLabel.snp.bottom).offset(16)
               make.leading.equalTo(self.snp.leading).offset(16)
               make.trailing.equalTo(self.snp.trailing).offset(-16)
               make.bottom.equalTo(self.snp.bottom).offset(-16)
           }
       }
}

extension FavoritesView: IFavoritesView {
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
