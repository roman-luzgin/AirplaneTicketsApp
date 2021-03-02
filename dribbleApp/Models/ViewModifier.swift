//
//  ViewModifier.swift
//  dribbleApp
//
//  Created by Roman Luzgin on 28.02.21.
//

import SwiftUI

// View modifier for the black buttons
struct Buttons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}


struct FlightDetailsMenu: ViewModifier {
    var height: Int
    
    func body(content: Content) -> some View {
        
        content
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: CGFloat(self.height))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .padding(.horizontal, 25)
    }
}
