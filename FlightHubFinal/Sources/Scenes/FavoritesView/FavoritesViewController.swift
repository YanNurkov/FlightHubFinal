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
        presenter?.viewDidLoad(ui: self.ui)
        ui.tableDataSource = self
        ui.tableViewDelegate = self
    }
    
    override func loadView() {
        self.view = self.ui
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchFavoriteAirport()
    }
    
    // MARK: - Functions
    
    func reloadTable() {
        ui.tableView.reloadData()
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.countOfAirport() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ("\(presenter?.fetchCode(for: indexPath) ?? ""), \(presenter?.fetchName(for: indexPath) ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showAirportInfo(index: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteAirport(index: indexPath)
        }
    }
}
