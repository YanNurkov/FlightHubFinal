//
//  NetworkService.swift
//  FlightHubFinal
//
//  Created by Ян Нурков on 17.06.2023.
//

import Foundation

class NetworkService {
    func fetchSuggestions(with searchText: String, completion: @escaping ([AutocompleteResponse]) -> Void) {
        guard let searchTerm = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let urlString = "https://autocomplete.travelpayouts.com/places2?locale=ru&types[]=airport&types[]=city&term=\(searchTerm)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    var autocompleteResponses: [AutocompleteResponse] = []
                    
                    for json in jsonArray {
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                        let autocompleteResponse = try JSONDecoder().decode(AutocompleteResponse.self, from: jsonData)
                        autocompleteResponses.append(autocompleteResponse)
                    }
                    
                    DispatchQueue.main.async {
                        completion(autocompleteResponses)
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }.resume()
    }
}
