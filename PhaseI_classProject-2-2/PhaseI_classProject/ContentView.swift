//
//  ContentView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    @State var isLoggedIn: Bool = false
    @State var showError: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Log into the application")
                HStack{
                    Text("Username:")
                    TextField("Enter username", text: $username)
                }
                HStack{
                    Text("Password:")
                    TextField("Enter Password", text: $password)
                }
                NavigationLink("Forgot Username/Password?"){
                    resetDetails()
                }
            }
            .padding()
            if showError{
                Text("Invalid Login Details")
                    .foregroundStyle(Color.red)
            }
            Button("Login"){
                if(username == "Test" && password == "Test"){
                    isLoggedIn = true
                }
                else{
                    showError = true
                }
            }
            .navigationDestination(isPresented: $isLoggedIn){
                PatientView()
            }
        }
    }
}

#Preview {
    ContentView()
}
