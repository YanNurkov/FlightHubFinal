//
//  CoreDataModel.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataModel {
    var persons: [AirportCode] = []
    
    let context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
    
    private var managedObject: AirportCode {
        AirportCode(context: context)
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                print("Save \(context)")
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAirport() -> [AirportCode] {
        let fetchRequest = NSFetchRequest<AirportCode>(entityName: "AirportCode")
        do {
            persons = try context.fetch(fetchRequest)
        } catch {
            print("Cannot fetch Expenses")
        }
        return persons
    }
    
    func addAirport(airportCodeData: String, airportName: String) {
        
        let fetchRequest: NSFetchRequest<AirportCode> = AirportCode.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code == %@ AND name == %@", airportCodeData, airportName )
        
        do {
            let matchingAirportCodes = try context.fetch(fetchRequest)
            if let existingAirportCode = matchingAirportCodes.first {
                print("Airport code and name already exist: \(existingAirportCode.code ?? "") - \(existingAirportCode.name ?? "")")
                return
            }
        } catch {
            print("Error fetching airport codes: \(error)")
            return
        }
        
        let airportCodeObject = AirportCode(context: context)
        airportCodeObject.code = airportCodeData
        airportCodeObject.name = airportName
        
        saveContext()
    }
    
    func deleteAirport(airport: AirportCode) {
        context.delete(airport)
        saveContext()
    }
}
