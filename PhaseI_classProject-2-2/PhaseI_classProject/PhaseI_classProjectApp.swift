//
//  PhaseI_classProjectApp.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI
import SwiftData

@main
struct PhaseI_classProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            People.self,
            appointmentData.self,
            ProviderNotes.self,
            RecentHistory.self
        ])
    }
}
