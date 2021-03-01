//
//  ContentView.swift
//  dribbleApp
//
//  Created by Roman Luzgin on 28.02.21.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("wasOpened") var wasOpened = false
    
    var body: some View {
        // If the app has not been opened before on this device show GetStartedView
        if !wasOpened {
            GetStartedView()
        } else {
            FlightsView()
                .tabItem {
                    Label("home", systemImage: "airplane.circle.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
