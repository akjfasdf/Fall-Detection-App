//
//  dataModel.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import Foundation
import SwiftUI

@Observable
class HospitalData{
    var hospitals: [APINinjasOutput] = []
    
    func getHospitals(city: String) async {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.api-ninjas.com/v1/hospitals?city=\(encodedCity)"
        
        print("URL: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Mku5K56e16qxz4lz20Sfiq9n1swB4rAMKGoTSBkG", forHTTPHeaderField: "X-Api-Key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
           
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let jsonStr = String(data: data, encoding: .utf8){
                print("API Response: \(jsonStr)")
            }
            
            if let errorResponse = try? JSONDecoder().decode([String: String].self, from: data), let error = errorResponse["error"] {
                print("API Error: \(error)")
                return
            }
            // Decode array response
            hospitals = try JSONDecoder().decode([APINinjasOutput].self, from: data)
            print("Hospitals loaded: \(hospitals.count)")
            
            
            let decoded = try JSONDecoder().decode([APINinjasOutput].self, from: data)
            hospitals = decoded
        }
        catch {
            print("Error fetching hospitals: \(error)")
        }
    }

}

