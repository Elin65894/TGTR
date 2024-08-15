//
//  VitaminScheduleView.swift
//  TGTR
//
//  Created by Elin.Andersson on 2024-08-15.
//

import Foundation

import FirebaseCore
//import FirebaseFirestore
//import FirebaseMessaging // Om du behöver Firebase Messaging

import SwiftUI

struct VitaminScheduleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
           // Text("D-Vitamin Schema")
           //     .font(.title)
            //    .padding(.bottom, 20)
           
            
            Text("För barn upp till 5 år:")
                .font(.headline)
            
            Text("Dosering: 80 IE/droppe")
                .font(.subheadline)
            
            Text("Ge 5 droppar per dag.")
                .font(.subheadline)
            
            Text("Det är särskilt viktigt att ge D-vitamin de första två åren.")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            Text("Doseringstabell:")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("Ålder:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Droppar/dag:")
                        .fontWeight(.bold)
                }
                Divider()
                HStack {
                    Text("0-2 år")
                    Spacer()
                    Text("5 droppar")
                }
                Divider()
                HStack {
                    Text("3-5 år")
                    Spacer()
                    Text("5 droppar")
                }
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            
            NavigationLink(destination: CalendarView()) {
                Text("Öppna kalender")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("D-Vitamin Schema")
    }
}

struct VitaminScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        VitaminScheduleView()
    }
}


