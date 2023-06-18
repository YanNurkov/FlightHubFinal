//
//  FavoritesViewController.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit
protocol IFavoritesViewController {
    func reloadTable()
}

class FavoritesViewController: UIViewController, IFavoritesViewController {
    var ui = FavoritesView()
    var presenter: IFavoritesViewPresenter?
    private var favorites: [AirportCode] = []
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad(ui: self.ui)
        self.ui.tableDataSource = self
        self.ui.tableViewDelegate = self
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter?.fetchFavoriteAirport()
    }
    
    // MARK: - Functions
    
    func reloadTable() {
        self.ui.tableView.reloadData()
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.countOfAirport() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ("\(self.presenter?.fetchCode(for: indexPath) ?? ""), \(self.presenter?.fetchName(for: indexPath) ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.showAirportInfo(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presenter?.deleteAirport(index: indexPath)
        }
    }
}
