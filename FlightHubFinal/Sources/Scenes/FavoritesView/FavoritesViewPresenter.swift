//
//  FavoritesViewPresenter.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

protocol IFavoritesViewPresenter: AnyObject {
    func viewDidLoad(ui: IFavoritesView)
    func fetchFavoriteAirport()
    func fetchName(for index: IndexPath) -> String
    func fetchCode(for index: IndexPath) -> String
    func countOfAirport() -> Int
    func deleteAirport(index: IndexPath)
    func showAirportInfo(index: IndexPath)
}

final class FavoritesViewPresenter: IFavoritesViewPresenter {
    private var router: RouterProtocol
    private var ui: IFavoritesView?
    private let dataLoader: APIProtocol
    var view: IFavoritesViewController?
    var favoriteAirport: [AirportCode]?
    var model = CoreDataModel()
    
    required init(router: RouterProtocol, ui: IFavoritesView, loader: APIProtocol, view: IFavoritesViewController) {
        self.ui = ui
        self.router = router
        self.dataLoader = loader
        self.view = view
    }
    
    func viewDidLoad(ui: IFavoritesView) {
        self.ui = ui
    }
    
    func fetchAllAirport() {
        favoriteAirport = model.getAirport()
        view?.reloadTable()
    }
    
    func fetchFavoriteAirport() {
        favoriteAirport = model.getAirport()
        view?.reloadTable()
    }
    
    func fetchName(for index: IndexPath) -> String {
        return favoriteAirport?[index.row].name ?? ""
    }
    
    func fetchCode(for index: IndexPath) -> String {
        return favoriteAirport?[index.row].code ?? ""
    }
    
    func countOfAirport() -> Int {
        return favoriteAirport?.count ?? 0
    }
    
    func deleteAirport(index: IndexPath) {
        guard let airport = favoriteAirport?[index.row] else { return }
        model.deleteAirport(airport: airport)
        fetchAllAirport()
    }
    
    func showAirportInfo(index: IndexPath) {
        guard let airport = favoriteAirport?[index.row] else { return }
        let annotation = AirportAnnotation()
        annotation.title = airport.name
        annotation.subtitle = airport.code
        router.dismiss()
        router.showAirportInfo(annotation: annotation)
    }
}
