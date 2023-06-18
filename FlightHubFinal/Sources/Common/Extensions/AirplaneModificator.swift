//
//  AirplaneModificator.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

extension String {
    func appendManufacturerName() -> String {
        let manufacturer: String
        
        switch prefix(2) {
        case "B7":
            manufacturer = "Boeing"
        case "A3":
            manufacturer = "Airbus"
        case "A2":
            manufacturer = "Airbus"
        case "C1":
            manufacturer = "Cessna"
        case "CL":
            manufacturer = "Bombardier Challenger"
        case "LJ":
            manufacturer = "Learjet"
        case "R2":
            manufacturer = "Robinson Helicopter Company"
        case "MD":
            manufacturer = "McDonnell Douglas"
        case "CR":
            manufacturer = "Bombardier"
        case "E1":
            manufacturer = "Embraer"
        case "AT":
            manufacturer = "ATR"
        case "DH":
            manufacturer = "De Havilland Canada"
        case "SU":
            manufacturer = "Sukhoi Superjet"
        default:
            manufacturer = ""
        }
        
        return manufacturer.isEmpty ? self : manufacturer + " " + self
    }
}
