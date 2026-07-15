//
//  resetDetails.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI

struct resetDetails: View {
    @State var email: String = ""
    @State var buttonTapped: Bool = false
    var body: some View {
        VStack{
            Text("Enter your email to reset your username or password")
                .navigationTitle("Account Reset")
            HStack{
                Text("Email: ")
                TextField("Enter email", text:$email)
            }
            Button("Reset Account Details"){
                buttonTapped = true
            }
            if buttonTapped{
                Text("A reset link has been sent to this email!")
            }
        }
    }
}

#Preview {
    resetDetails()
}
