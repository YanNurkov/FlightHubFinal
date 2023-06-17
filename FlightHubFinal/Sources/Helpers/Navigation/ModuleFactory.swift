//
//  ModuleFactory.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation
import UIKit

protocol IModuleFactory {
    func makeMainModule(router: RouterProtocol) -> UIViewController
    func makeAirPlaneInfoModule(router: RouterProtocol, annotation: AircraftAnnotation, allAirports: [Airport]) -> UIViewController
    func makeAirportInfoModule(router: RouterProtocol, annotation: AirportAnnotation) -> UIViewController
    func makeFavoriteModule(router: RouterProtocol) -> UIViewController
}

class ModuleFactory: IModuleFactory {
    func makeMainModule(router: RouterProtocol) -> UIViewController {
        let ui = MainView()
        let loader = DataLoader()
        let vc = MainViewController()
        let presenter = MainViewPresenter(router: router, ui: ui, loader: loader, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    func makeAirPlaneInfoModule(router: RouterProtocol, annotation: AircraftAnnotation, allAirports: [Airport]) -> UIViewController {
        let ui = AirPlaneView()
        let loader = DataLoader()
        let vc = AirPlaneViewController(annotation: annotation, allAirports: allAirports)
        let presenter = AirPlanePresenter(router: router, ui: ui, loader: loader, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    func makeAirportInfoModule(router: RouterProtocol, annotation: AirportAnnotation) -> UIViewController {
        let ui = AirportInfoView()
        let loader = DataLoader()
        let vc = AirportInfoViewController(annotation: annotation)
        let presenter = AirportInfoPresenter(router: router, ui: ui, loader: loader, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    func makeFavoriteModule(router: RouterProtocol) -> UIViewController {
        let ui = FavoritesView()
        let loader = DataLoader()
        let vc = FavoritesViewController()
        let presenter = FavoritesViewPresenter(router: router, ui: ui, loader: loader, view: vc)
        vc.presenter = presenter
        return vc
    }
}
