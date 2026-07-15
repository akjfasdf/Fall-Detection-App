//
//  futureAppointmentsView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import SwiftUI
import SwiftData

struct futureAppointmentsView: View {
    @Query var apptData: [appointmentData]
    @Environment(\.modelContext) private var content
    
    var body: some View {
        NavigationStack{
            List(apptData){ appt in
                Section{
                        Text("Appointment with " + (appt.provider))
                            .fontWeight(.bold)
                        Text("Hospital: " + appt.hospital)
                        Text("Date: " + appt.date)
                        Text("Reason: " + appt.reason)
                }
            }
            .navigationTitle("Future Appointments!")
        }
        
    }
}

#Preview {
    futureAppointmentsView()
}
