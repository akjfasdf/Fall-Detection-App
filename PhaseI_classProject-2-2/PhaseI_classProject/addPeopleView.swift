//
//  addPeopleView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI
import SwiftData

@Model
class People{
    var firstName: String
    var lastName : String
    var contactInfo : String
    var relationship : String
    
    init(firstName: String, lastName: String, contactInfo: String, relationship: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.contactInfo = contactInfo
        self.relationship = relationship
    }
}

struct addPeopleView: View {
    @Query var personData: [People]
    @Environment(\.modelContext) private var content
    @Environment(\.dismiss) var dismiss
    
    @State var personAdded: Bool = false
    @State var personAddedStr: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var contactInfo: String = ""
    @State var relationship: String = ""
    
    var body: some View {
        NavigationStack{
            Text("Add people!")
            .navigationTitle("Add people!")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Close"){
                        dismiss()
                    }
                }
            }
            
            VStack{
                HStack{
                    Text("First Name: ")
                    TextField(" ", text: $firstName)
                }
                HStack{
                    Text("Last Name: ")
                    TextField(" ", text: $lastName)
                }
                HStack{
                    Text("Contact Info: ")
                    TextField(" ", text: $contactInfo)
                }
                HStack{
                    Text("Relationship: ")
                    TextField(" ", text: $relationship)
                }
                Button("Add Person"){
                    let person = People(firstName: firstName, lastName: lastName, contactInfo: contactInfo, relationship: relationship)
                    content.insert(person)
                    personAdded = true
                    personAddedStr = firstName +  " " + lastName
                }
                
                if personAdded{
                    Text(personAddedStr + " added!")
                }
            }
        }
    }
}

#Preview {
    addPeopleView()
}
