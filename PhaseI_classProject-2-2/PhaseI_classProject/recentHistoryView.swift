//
//  recentHistoryView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import SwiftUI
import SwiftData

@Model
class ProviderNotes: Hashable {
    var providerName: String
    var appointmentDate: String
    var appointmentReason: String
    var specialNotes: String
    
    init(providerName: String, appointmentDate: String, appointmentReason: String, specialNotes: String) {
        self.providerName = providerName
        self.appointmentDate = appointmentDate
        self.appointmentReason = appointmentReason
        self.specialNotes = specialNotes
    }
}

@Model
class RecentHistory{
    var occurence: String
    var date: String
    
    init(occurence: String, date: String) {
        self.occurence = occurence
        self.date = date
    }
}

let providerNotesList = [
    ProviderNotes(providerName: "Dr. Smith", appointmentDate: "03/20/26", appointmentReason: "Checkup", specialNotes: "Patient's A1C level is 6.2%. He is at risk for type 2 diabetes."),
    ProviderNotes(providerName: "Dr. Johnson", appointmentDate: "03/15/26", appointmentReason: "Follow-up", specialNotes: "Blood pressure is slightly elevated. Monitor weekly."),
    ProviderNotes(providerName: "Dr. Lee", appointmentDate: "03/10/26", appointmentReason: "Consultation", specialNotes: "Patient reports occasional chest pain. EKG scheduled.") ]

struct recentHistoryView: View {
    @Query var notes: [RecentHistory]
    @Environment(\.modelContext) private var content
    
    @State var selectedProvider: ProviderNotes = ProviderNotes(providerName: "Dr. Smith", appointmentDate: "3/20/26", appointmentReason: "Checkup", specialNotes: "Patient's A1C level is 6.2%. He is at risk for type 2 diabetes.")
    @State var seeNotes: Bool = false
    
    var body: some View {
        NavigationStack{
            List(notes){ note in
                Section{
                    Text(note.occurence)
                    Text("Date: " + note.date)
                }
            }
            .navigationTitle("Recent History")
        }
        .onAppear {
            for hist in providerNotesList {
                let occurenceString = "Appointment with " + hist.providerName
                let alreadyExists = notes.contains { $0.occurence == occurenceString && $0.date == hist.appointmentDate }
                guard !alreadyExists else { continue }
                
                let history = RecentHistory(
                    occurence: occurenceString,
                    date: hist.appointmentDate
                )
                content.insert(history)
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("See Provider Notes"){
                    seeNotes = true
                }
            }
        }
        .sheet(isPresented: $seeNotes){
            NavigationStack{
                VStack{
                    Text("Provider Notes:")
                        .padding()
                        .toolbar{
                            ToolbarItem(placement: .navigationBarTrailing){
                                Button("Close"){
                                    seeNotes = false
                                }
                            }
                        }
                    Picker("Select Provider", selection: $selectedProvider) {
                        ForEach(providerNotesList, id: \.self) { provider in
                            Text(provider.providerName).tag(provider)
                        }
                    }
                    .pickerStyle(.menu)
                    VStack(alignment: .leading){
                        Text("Appointment Date: \(selectedProvider.appointmentDate)")
                        Text("Appointment Reason: \(selectedProvider.appointmentReason)")
                        Text("Special Notes: \(selectedProvider.specialNotes)")
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    recentHistoryView()
}
