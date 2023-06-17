//
//  AlertView.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import UIKit

struct Alert: Equatable {
    var title: String
    var message: String
    var textButtonOk: String
    var textButtonCancel: String
}

final class AlertView {
    static func showAlertStatus(type: Alert, okHandler: ((UIAlertAction) -> Void)? = nil, view: UIViewController) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.textButtonOk, style: .default, handler: okHandler))
        view.present(alert, animated: true, completion: nil)
    }
}

extension Alert {
    static let errorData = Alert(title: "Error",
                                 message: "Failed to fetch aircraft data",
                                 textButtonOk: "Ok",
                                 textButtonCancel: "")
}
