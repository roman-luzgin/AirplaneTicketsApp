//
//  Menu.swift
//  AirTicketAppDribble
//
//  Created by Roman Luzgin on 01.03.21.
//

import SwiftUI

struct Menu: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                    .foregroundColor(.black)
                    .font(.custom("Montserrat-Semibold", size: 24))
                    .padding()
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                NavigationLink(
                    destination: Text("Profile")) {
                    Text("Profile")
                        .foregroundColor(.black)
                        .font(.custom("Montserrat-Semibold", size: 24))
                        .padding()
                }
                NavigationLink(
                    destination: Text("Settings")) {
                    Text("Settings")
                        .foregroundColor(.black)
                        .font(.custom("Montserrat-Semibold", size: 24))
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "F2F2F2").ignoresSafeArea())
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
