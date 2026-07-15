//
//  SwiftUIView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/20/26.
//

import SwiftUI

struct PatientView: View {
    @State var showMap: Bool = false
    var body: some View {
        VStack{
            Text("Patient Dashboard")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        NavigationLink("Add People!"){
                            addPeopleView()
                        }
                    }
                    ToolbarItem(placement: .topBarLeading){
                        NavigationLink("Set Appointment"){
                            setAppt()
                        }
                    }
                }
            List{
                NavigationLink("View Hospitals in Current Location"){
                    mapOfCurrentHospitals()
                }
                NavigationLink("View People in Your Circle"){
                    peopleView()
                }
                NavigationLink("View Upcoming Appointments"){
                    futureAppointmentsView()
                }
                NavigationLink("See Recent History"){
                    recentHistoryView()
                }
            }
            Text("Disclaimer:  This app can only display hospitals in your area if you are in the United States of America.")
            Spacer()
            Spacer()
            Spacer()
            Text("The fall stimulation button below demonstrates what would happen if a fall were to occur. In a real world setting, users would be wearing a monitor that would detect the fall and send a signal to the app to trigger the response seen in the stimulator.")
            Spacer()
            NavigationLink("Fall Detection Stimulation"){
                FallDetectionView()
            }
        
        }
    }
}
