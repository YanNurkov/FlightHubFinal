//
//  Router.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: IModuleFactory? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showAirPlaneInfo(annotation: AircraftAnnotation, allAirports: [Airport])
    func showAirportInfo(annotation: AirportAnnotation)
    func showFavoriteView()
    func dismiss()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: IModuleFactory?
    
    init(navigationController: UINavigationController, assemblyBuilder: IModuleFactory) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = self.navigationController {
            guard let mainViewController = self.assemblyBuilder?.makeMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showAirPlaneInfo(annotation: AircraftAnnotation, allAirports: [Airport]) {
        if let navigationController = self.navigationController {
            guard let airPlane = self.assemblyBuilder?.makeAirPlaneInfoModule(router: self, annotation: annotation, allAirports: allAirports) else { return }
            let sheet = airPlane.presentationController as? UISheetPresentationController
            sheet?.detents = [.medium(), .large()]
            navigationController.present(airPlane, animated: true)
        }
    }
    
    func showAirportInfo(annotation: AirportAnnotation) {
        if let navigationController = self.navigationController {
            guard let infoViewController = assemblyBuilder?.makeAirportInfoModule(router: self, annotation: annotation) else { return }
            let sheet = infoViewController.presentationController as? UISheetPresentationController
            sheet?.detents = [.medium(), .large()]
            navigationController.present(infoViewController, animated: true)
        }
    }
    
    func showFavoriteView() {
        if let navigationController = self.navigationController {
            guard let favoriteViewController = assemblyBuilder?.makeFavoriteModule(router: self) else { return }
            let sheet = favoriteViewController.presentationController as? UISheetPresentationController
            sheet?.detents = [.medium(), .large()]
            navigationController.present(favoriteViewController, animated: true)
        }
    }
    
    func dismiss() {
        self.navigationController?.topViewController?.dismiss(animated: true, completion: nil)
    }
}
