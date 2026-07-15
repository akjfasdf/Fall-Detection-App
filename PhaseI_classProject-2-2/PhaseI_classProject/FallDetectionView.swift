//
//  FallDetectionView.swift
//  PhaseI_classProject
//
//  Created by Shriya Vallabhaneni on 3/21/26.
//

import SwiftUI
import SwiftData

struct FallDetectionView: View {
    @State var fallDetected: Bool = false
    @State var countdown: Int = 10
    @State var emergencyCalled: Bool = false
    
    @Query var notes: [RecentHistory]
    @Environment(\.modelContext) private var content

    var body: some View {
        VStack(spacing: 20) {
            Text("Fall Detection")

            if emergencyCalled {
                Text("Emergency Services Called!")
                    .foregroundColor(.red)
            }

            Button("Simulate Fall Detection") {
                startFallDetection()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .alert("Fall Detected!", isPresented: $fallDetected) {
            Button("I'm OK", role: .cancel) {
                cancelAlert()
            }
            Button("Call Emergency Services", role: .destructive) {
                callEmergency()
            }
        } message: {
            Text("Are you okay? Emergency Services will automatically be called in 10 seconds if there is no response")
        }
        .onChange(of: countdown){newValue in
            if newValue == 0{
                callEmergency()
            }
        }
    }


    func startFallDetection() {
        emergencyCalled = false
        countdown = 10
        fallDetected = true


        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { t in
            if countdown > 0 {
                countdown -= 1
            }
            else{
                t.invalidate()
            }
        }
    }


    func cancelAlert() {
        fallDetected = false
        countdown = 10
    }


    func callEmergency() {
        fallDetected = false
        countdown = 10
        let dateStr = Date().formatted(.verbatim("\(month: .twoDigits)/\(day: .twoDigits)/\(year: .padded(4))",
                                                 timeZone: .current,
                                                 calendar: .current))
                                       
        let history = RecentHistory(occurence: "Emergency Fall", date: dateStr)
        content.insert(history)
        emergencyCalled = true
    }
}


#Preview {
    FallDetectionView()
}
