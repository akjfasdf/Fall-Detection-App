//
//  peopleView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni (Student) on 4/17/26.
//

import SwiftUI
import SwiftData

struct peopleView: View {
    @Query var personData: [People]
    @Environment(\.modelContext) private var content
    @Environment(\.dismiss) var dismiss
    @State var removePerson: Bool = false
    
    var body: some View {
        NavigationStack{
            List(personData){ people in
                Section{
                    Text((people.firstName) + " " + (people.lastName))
                        .fontWeight(.bold)
                    Text("Contact Info: " + people.contactInfo)
                    Text("Relationship: " + people.relationship)
                }
            }
        }
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Remove a Person"){
                    removePerson = true
                }
            }
        }
        .sheet(isPresented: $removePerson){
            List(personData){ people in
                Section{
                    Text((people.firstName) + " " + (people.lastName))
                    Button(action:{
                        content.delete(people)
                        try? content.save()
                    }) {
                        Text("Remove Person")
                    }
                }
            }
            Button("Close"){
                removePerson = false
            }
        }
    }
}

#Preview {
    peopleView()
}
