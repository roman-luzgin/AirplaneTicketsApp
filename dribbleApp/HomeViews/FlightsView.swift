//
//  FlightsView.swift
//  dribbleApp
//
//  Created by Roman Luzgin on 28.02.21.
//

import SwiftUI

struct FlightsView: View {
    @AppStorage("userName") var userName = "Username"
    @State var menuOpened = false
    @State var from = ""
    @State var to = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Find flights that suit your timing and budget")
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.black)
                            .font(.custom("Montserrat-Bold", size: 32))
                            .padding()
                            .padding(.trailing, 40)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F2F2F2"))
                    .padding(.horizontal)
                    
                    VStack {
                        HStack {
                            Image(systemName: "airplane")
                                .resizable()
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(-45))
                                .frame(width: 20, height: 20)
                                .padding(8)
                            HStack {
                                TextField("From", text: $from)
                                    .font(.custom("Montserrat-Medium", size: 16))
                                    .foregroundColor(Color.black.opacity(0.8))
                                Spacer()
                            }
                        }
                        Divider()
                            .padding(.leading, 50)
                        HStack {
                            Image(systemName: "airplane")
                                .resizable()
                                .foregroundColor(.black)
                                .rotationEffect(.degrees(45))
                                .frame(width: 20, height: 20)
                                .padding(8)
                            HStack {
                                TextField("To", text: $to)
                                    .font(.custom("Montserrat-Medium", size: 16))
                                    .foregroundColor(Color.black.opacity(0.8))
                                Spacer()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 120)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding(.horizontal, 25)
                    .padding(.top, 30)
                    
                    // Continue button is a navigation link to the next screen
                    NavigationLink(destination: FlightDetails(destinationFrom: from,
                                                              destinationTo: to)) {
                        HStack {
                            Text("Continue")
                                .foregroundColor(.white)
                                .font(.custom("Montserrat-Semibold", size: 16))
                            Spacer()
                            Image(systemName: "chevron.right.2")
                                .foregroundColor(.white)
                                .font(.headline)
                        }
                        .padding(.horizontal)
                        .modifier(Buttons())
                        .padding(.horizontal, 25)
                        .padding(.top, 10)
                    }
                    
                    HStack {
                        Text("Best Tours")
                            .foregroundColor(.black)
                            .font(.custom("Montserrat-Semibold", size: 18))
                        Spacer()
                        NavigationLink(destination: Text("Best Tours")) {
                            Image(systemName: "arrow.right")
                                .renderingMode(.original)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                    .padding(.horizontal, 25)
                    
                    // Tours horizontal grid with scrollview
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: [GridItem(.fixed(1))], spacing: 20, content: {
                            ForEach(Tours, id: \.id) { tour in
                                NavigationLink(destination: Text("\(tour.city)")) {
                                    TourView(tour: tour)
                                }
                            }
                        })
                        .padding(.horizontal, 25)
                    }
                    .frame(height: 320)
                    .padding(.bottom, 50)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "F2F2F2").edgesIgnoringSafeArea(.all))
            .navigationBarItems(leading: Text("Hi \(userName)!")
                                    .font(.custom("Montserrat-Semibold", size: 16))
                                    .foregroundColor(.black)
                                    .padding(.leading, 15),
                                trailing: Image(systemName: "lineweight")
                                    .font(Font.title2)
                                    .foregroundColor(.black)
                                    .padding(.trailing, 15)
                                    .onTapGesture {
                                        menuOpened.toggle()
                                    }
                                    .sheet(isPresented: $menuOpened, content: {
                                        Menu()
                                    }))
        }
        
        
        
        
    }
}

struct FlightsView_Previews: PreviewProvider {
    static var previews: some View {
        FlightsView()
            
            
    }
}
