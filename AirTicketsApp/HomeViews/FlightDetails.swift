//
//  FlightDetails.swift
//  dribbleApp
//
//  Created by Roman Luzgin on 28.02.21.
//

import SwiftUI

struct FlightDetails: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var destinationFrom: String
    var destinationTo: String
    
    @State var roundTrip = false
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var countPassengers = 1
    @State var cabinClass = "Business Class"
    
    let cabinClassList = ["Business Class", "Economy Class","First Class"]
    
    var body: some View {
        VStack {
            // Custom back button
            BackButton()
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
                .padding(.vertical)
            
            ScrollView {
                        
                        ZStack {
                            Divider()
                                .padding(.horizontal, 55)
                            HStack {
                                Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Spacer()
                                Image(systemName: "airplane")
                                    .foregroundColor(.black)
                                    //.rotationEffect(.degrees(-45))
                                Spacer()
                                Image(systemName: "circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            .padding(.horizontal, 25)
                        }
                       
                        HStack {
                            VStack(alignment: .leading) {
                                Text(aeroports[destinationFrom] ?? "XXX")
                                    .foregroundColor(.black)
                                    .font(.custom("Montserrat-Bold", size: 32))
                                Text(destinationFrom)
                                    .foregroundColor(.gray)
                                    .font(.custom("Montserrat-Regular", size: 14))
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text(aeroports[destinationTo] ?? "XXX")
                                    .foregroundColor(.black)
                                    .font(.custom("Montserrat-Bold", size: 32))
                                Text(destinationTo)
                                    .foregroundColor(.gray)
                                    .font(.custom("Montserrat-Regular", size: 14))
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 25)
                        
                        HStack {
                            Image(systemName: "repeat")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Round Trip")
                                .foregroundColor(.black)
                                .font(.custom("Montserrat-Regular", size: 14))
                                .padding(.leading, 10)
                            Spacer()
                            Toggle(isOn: $roundTrip) {
                                
                            }
                        }
                        .modifier(FlightDetailsMenu(height: 50))
                        .padding(.vertical, 10)
                        
                        //Date pickers
                        VStack {
                            HStack {
                                Image(systemName: "arrow.right.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .rotationEffect(.degrees(-45))
                                DatePicker("", selection: $fromDate, in: roundTrip ? ...toDate : ...Date().addingTimeInterval(3600*24*365), displayedComponents: .date)
                                    .datePickerStyle(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Date Picker Style@*/DefaultDatePickerStyle()/*@END_MENU_TOKEN@*/)
                                    .accentColor(.black)
                                    .frame(width: 120)
                                                        
                                    
                                Spacer()
                        
                            }
                            .padding(.vertical, 5)
                            
                            Divider()
                                .padding(.leading, 20)
                            HStack {
                                Image(systemName: "arrow.right.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .rotationEffect(.degrees(45))
                                DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .date)
                                    .accentColor(.black)
                                    .disabled(roundTrip ? false : true)
                                    .frame(width: 120)
                                Spacer()
                                
                            }
                            .opacity(roundTrip ? 1 : 0.5)
                            .padding(.vertical, 5)
                        }
                        .modifier(FlightDetailsMenu(height: 120))
                        .padding(.vertical,10)
                        
                        VStack {
                            HStack {
                                Image(systemName: returnClassImage(cabinClass: cabinClass))
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Picker(selection: $cabinClass, label:
                                        HStack {
                                            Text("\(cabinClass)")
                                                .foregroundColor(.black)
                                                .font(.custom("Montserrat-Regular", size: 14))
                                            Spacer()
                                        }
                                        .frame(width: 150, height: 30)
                                        .padding(.leading, 15)
                                
                                ) {
                                    ForEach(cabinClassList, id: \.self) { cabinClass in
                                        Text("\(cabinClass)")
                                            .foregroundColor(.black)
                                            .font(.custom("Montserrat-Regular", size: 14))
                                            //.padding(.leading, 10)
                                            .tag(cabinClass)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                .frame(width: 150, height: 30)
                                .background(Color.white)
                                .pickerStyle(MenuPickerStyle())
                                
                                Spacer()
                                
                            }
                            .padding(.vertical, 5)
                            Divider()
                                .padding(.leading, 20)
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                                Stepper(value: $countPassengers, in: 1...20) {
                                    Text("\(countPassengers) passenger\(countPassengers==1 ? "" : "s")")
                                        .foregroundColor(.black)
                                        .font(.custom("Montserrat-Regular", size: 14))
                                }
                                //Giving a haptic feedback on change of number of passengers
                                .onChange(of: countPassengers, perform: { _ in
                                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                        impactMed.impactOccurred()
                                })
                                .padding(.leading, 10)
                            }
                            .padding(.vertical, 5)
                        }
                        .modifier(FlightDetailsMenu(height: 120))
                        .padding(.vertical,10)
                        
                        Spacer()
                        
                        NavigationLink(
                            destination: CalculatedRoute(destinationFrom: destinationFrom, destinationTo: destinationTo, roundTrip: $roundTrip, fromDate: $fromDate, toDate: $toDate, countPassengers: $countPassengers, cabinClass: $cabinClass),
                            label: {
                                HStack{
                                    Text("Search Flights")
                                        .foregroundColor(.white)
                                        .font(.custom("Montserrat-Semibold", size: 16))
                                    Spacer()
                                    Image(systemName: "chevron.right.2")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                .modifier(Buttons())
                                .padding(.horizontal, 25)
                                .padding(.vertical, 40)
                            })
                    }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "F2F2F2").edgesIgnoringSafeArea(.all))
        // Since we use custom back button, native Swift back gesture would not work
        // This is to add a custom drag gesture
        .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                    if(value.startLocation.x < 20 && value.translation.width > 100) {
                        self.mode.wrappedValue.dismiss()
                    }
        }))
    }
    
    // Change image next to Cabin Class depending on the actual value
    func returnClassImage(cabinClass: String) -> String {
        switch cabinClass {
            case "Business Class":
                return "briefcase"
            case "Economy Class":
                return "bitcoinsign.circle"
            case "First Class":
                return "1.circle"
            default:
                return "circle"
        }
    }
}

struct FlightDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightDetails(destinationFrom: "London", destinationTo: "Paris")
    }
}


// Definition of the custom back button
struct BackButton: View {
    var body: some View {
        HStack {
            Image(systemName: "arrow.left")
                .resizable()
                .foregroundColor(.black)
                .frame(width: 30, height: 20)
                .padding(.leading, 25)
            Spacer()
        }
    }
}
