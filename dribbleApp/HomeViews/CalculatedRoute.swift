//
//  CalculatedRoute.swift
//  AirTicketAppDribble
//
//  Created by Roman Luzgin on 01.03.21.
//

import SwiftUI

struct CalculatedRoute: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var destinationFrom: String
    var destinationTo: String
    
    @Binding var roundTrip: Bool
    @Binding var fromDate: Date
    @Binding var toDate: Date
    @Binding var countPassengers: Int
    @Binding var cabinClass: String
    
    var body: some View {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY"
        
        return VStack {
            // Custom back button
            BackButton()
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
                .padding(.vertical)
            ScrollView {
                    VStack {
                        
                        
                        HStack {
                            Text("Options:")
                                .foregroundColor(.black)
                                .font(.custom("Montserrat-Bold", size: 24))
                            Spacer()
                        }
                        .padding(.horizontal, 25)
                        
                        VStack {
                            VStack(spacing: 5) {
                                HStack {
                                    Text("From")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Regular", size: 14))
                                    Spacer()
                                    Text("To")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Regular", size: 14))
                                }
                                HStack {
                                    Text("\(destinationFrom.isEmpty ? "XXX" : destinationFrom)")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Bold", size: 14))
                                        
                                    Spacer()
                                    
                                    Text("\(destinationTo.isEmpty ? "XXX" : destinationTo)")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Bold", size: 14))
                                }
                            }
                            .padding(10)
                            
                            Divider()
                                .padding(.leading, 15)
                            
                            VStack(spacing: 5) {
                                HStack {
                                    Text("Out")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Regular", size: 14))
                                    Spacer()
                                    if roundTrip {
                                        Text("Back")
                                            .foregroundColor(.black)
                                            .font(.custom("Montserrat-Regular", size: 14))
                                    }
                                }
                                HStack {
                                    Text("\(dateFormatter.string(from: fromDate))")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Bold", size: 14))
                                    
                                        
                                    Spacer()
                                    if roundTrip {
                                        Text("\(dateFormatter.string(from: toDate))")
                                            .foregroundColor(.black)
                                            .font(.custom("Montserrat-Bold", size: 14))
                                    }
                                }
                            }
                            .padding(10)
                            
                            Divider()
                                .padding(.leading, 15)
                            
                            HStack {
                                Text("\(countPassengers) passenger\(countPassengers==1 ? "" : "s"), \(cabinClass)")
                                    .foregroundColor(.black)
                                    .font(.custom("Montserrat-Regular", size: 14))
                                    
                                Spacer()
                            }
                            .padding(10)
                            
                            
                        }
                        .modifier(FlightDetailsMenu(height: 200))
                        .padding(.vertical, 5)
                        
                        HStack {
                            Text("Here is what we found!")
                                .foregroundColor(.black)
                                .font(.custom("Montserrat-Regular", size: 24))
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "F2F2F2"))
                        .padding(.vertical, 15)
                        .padding(.horizontal, 25)
                        
                        Spacer()
                        
                        LazyVStack(spacing: 20) {
                            ForEach(1..<10) {number in
                                HStack {
                                    Text("Option \(number)")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Semibold", size: 16))
                                        .padding(.leading, 15)
                                    Spacer()
                                }
                                .modifier(FlightDetailsMenu(height: 80))
                            }
                            
                        }
                        
                        
                    }
                    
                }
                
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .background(Color(hex:"F2F2F2").ignoresSafeArea())
        // Since we use custom back button, native Swift back gesture would not work
        // This is to add a custom drag gesture
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
                    
    }))
        
    }
}

struct CalculatedRoute_Previews: PreviewProvider {
    static var previews: some View {
        CalculatedRoute(destinationFrom: "Paris", destinationTo: "London", roundTrip: .constant(true), fromDate: .constant(Date()), toDate: .constant(Date()), countPassengers: .constant(1), cabinClass: .constant("Economy Class"))
    }
}
