//
//  APINinjasOutput.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import Foundation
import SwiftUI


struct APINinjasOutputList: Decodable {
    let hospitals: [APINinjasOutput]
}


struct APINinjasOutput: Decodable, Identifiable {
    let name: String
    let care_type: String?
    let address: String
    let city: String
    let state: String
    let zipcode: String
    let county: String
    let location_area_code: String
    let fips_code: String
    let timezone: String
    let latitude: String
    let longitude: String
    let phone_number: String?
    let website: String?
    let ownership: String?
    let bedcount: Int?
    
    var id: String {
        "\(name)-\(address)-\(zipcode)"
    }
    
    var fullAddress: String {
        "\(address), \(city), \(state) \(zipcode)"
    }
}
