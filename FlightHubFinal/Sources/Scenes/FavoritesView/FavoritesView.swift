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
        self.backgroundColor = .customBackgroundGray
        self.addSubview(self.tableView)
        self.addSubview(self.topLabel)
    }
}

// MARK: - Extensions

private extension FavoritesView {
    private func makeConstraints() {
        self.topLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(Layout.standartTop)
            make.leading.equalTo(self.snp.leading).offset(Layout.standartLeading)
            make.trailing.equalTo(self.snp.trailing).offset(Layout.standartTrailing)
            make.height.equalTo(Layout.topLabelHeight)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.topLabel.snp.bottom).offset(Layout.standartTop)
            make.leading.equalTo(self.snp.leading).offset(Layout.standartLeading)
            make.trailing.equalTo(self.snp.trailing).offset(Layout.standartTrailing)
            make.bottom.equalTo(self.snp.bottom).offset(Layout.standartBottom)
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

private extension FavoritesView {
    enum Layout {
        static let standartLeading: CGFloat = 16
        static let standartTrailing: CGFloat = -16
        static let standartTop: CGFloat = 16
        static let standartBottom: CGFloat = -16
        static let topLabelHeight: CGFloat = 25
    }
}
