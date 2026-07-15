//
//  mapOfCurrentHospitals.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import SwiftUI
import MapKit
import CoreLocation


@Observable
class LocationManager {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var city = ""
    
    func getLocationAndCity() async {
           print("Getting location...")
           let updates = CLLocationUpdate.liveUpdates()
           do {
               for try await update in updates {
                   if let location = update.location {
                       latitude = location.coordinate.latitude
                       longitude = location.coordinate.longitude
                       print("Coordinates: \(latitude), \(longitude)")
                       
                       let clLocation = CLLocation(latitude: latitude, longitude: longitude)
                       let geocoder = CLGeocoder()
                       let placemarks = try await geocoder.reverseGeocodeLocation(clLocation)
                       if let placemark = placemarks.first {
                           city = placemark.locality ?? "Phoenix"
                           print("City: \(city)")
                       }
                       break
                   }
               }
           }
        catch {
                print("Geocoding error: \(error)")
            }
        }
}


struct mapOfCurrentHospitals: View {
    @State private var locationManager = LocationManager()
    @State var hospitalData = HospitalData()
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $cameraPosition) {
            // User location marker
            UserAnnotation()
            
            // Hospital markers
            ForEach(hospitalData.hospitals) { hospital in
                if let lat = Double(hospital.latitude ?? ""),
                   let lon = Double(hospital.longitude ?? "") {
                    
                    Annotation(hospital.name, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                        VStack(spacing: 4) {
                            Image(systemName: "cross.fill")
                                .foregroundStyle(.white)
                                .padding(8)
                                .background(.red)
                                .clipShape(Circle())
                            VStack(spacing: 2) {
                                Text(hospital.name)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Text(hospital.fullAddress)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(6)
                            .background(.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                }
            }
        }
            .onAppear{
                Task {
                    await locationManager.getLocationAndCity()
                    await hospitalData.getHospitals(city: locationManager.city)
                }
            }
        }
    }
