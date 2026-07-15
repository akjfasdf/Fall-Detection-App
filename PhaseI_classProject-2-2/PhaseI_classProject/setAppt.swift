//
//  setAppt.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI
import SwiftData

@Model
class appointmentData{
    var hospital: String
    var provider: String
    var date: String
    var reason: String
    
    init(hospital: String, provider: String, date: String, reason: String) {
        self.hospital = hospital
        self.provider = provider
        self.date = date
        self.reason = reason
    }
}

struct setAppt: View {
    @Query var apptData: [appointmentData]
    @Environment(\.modelContext) private var content
    @Environment(\.dismiss) var dismiss

    @State var hospital:String = ""
    @State var provider: String = ""
    @State var date: String = ""
    @State var reason: String = ""
    @State var setAppointment: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text("Hospital: ")
                TextField("", text: $hospital)
            }
            HStack{
                Text("Provider: ")
                TextField("", text: $provider)
            }
            HStack{
                Text("Date: ")
                TextField("", text: $date)
            }
            HStack{
                Text("Reason: ")
                TextField("", text: $reason)
            }
            Button("Set Appointment!"){
                let appt = appointmentData(hospital: hospital, provider: provider, date: date, reason: reason)
                content.insert(appt)
                setAppointment = true
            }
            if setAppointment{
                Text("Your Appointment has been booked!")
            }
        }
        .navigationTitle("Book Appointment")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("Close"){
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    setAppt()
}
