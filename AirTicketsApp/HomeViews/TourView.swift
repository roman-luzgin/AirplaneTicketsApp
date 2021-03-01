//
//  TourView.swift
//  dribbleApp
//
//  Created by Roman Luzgin on 28.02.21.
//

import SwiftUI


// City tours cards
struct TourView: View {
    var tour: Tour
    
    var body: some View {
        VStack{
            tour.image
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .frame(maxWidth: .infinity, maxHeight: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .padding(4)
                .padding(.top, 3)
            Spacer()
            HStack {
                Text(tour.city)
                    .foregroundColor(.black)
                    .font(.custom("Montserrat-Semibold", size: 16))
                Spacer()
                Text(tour.country)
                    .foregroundColor(.black)
                    .font(.custom("Montserrat-Regular", size: 16))
            }
            .padding(.bottom, 12)
            .padding(.horizontal, 12)
            Spacer()
        }
        .frame(width: 230, height: 300, alignment: .center)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct TourView_Previews: PreviewProvider {
    static var previews: some View {
        TourView(tour: Tours[0])
    }
}
