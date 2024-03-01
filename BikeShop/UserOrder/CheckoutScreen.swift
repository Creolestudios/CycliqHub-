//
//  CheckoutScreen.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 05/01/24.
//

import SwiftUI

struct CheckoutScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("firstName") var firstName:String = ""
    @AppStorage("lastName") var lastName:String = ""
    @AppStorage("phoneNumber") var phoneNumber:String = ""
    @AppStorage("address") var address:String = ""
    var body: some View {
        NavigationView{
            ZStack{
                Color("shoppingBack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color("addressGrid1"), Color("addressGrid2")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        )
                        .frame(width: 350,height: 200)
                        .overlay(alignment:.topLeading,content: {
                            VStack(alignment:.leading){
                                Text("Name : \(firstName) \(lastName)")
                                Text("PhoneNumber : \(phoneNumber)")
                                Text("Address : \(address)")
                            }
                            .padding()
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        })
                    NavigationLink {
                        orderPlaced()
                            .navigationBarBackButtonHidden(true)
                    } label: {
                        VStack{
                            Text("Place Order")
                                .padding()
                                .font(.title3)
                                .fontWeight(.bold)
                                .background(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"), Color("DarkBlue")]), startPoint: .leading, endPoint: .bottomTrailing))
                                .foregroundColor(Color.white)
                                .cornerRadius(15)
                        }
                    }
                    Spacer()
                }
                .padding(.top,20)
            }
            .navigationBarItems(leading: Header)
        }
    }
    var Header:some View{
        HStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"),Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                )
                .frame(width: 40,height: 40)
                .shadow(color:.black,radius: 10)
                .overlay(alignment:.center,content:
                            {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                )
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
            Text("Order Status")
                .padding(.horizontal,10)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Color.white)
            Spacer()
        }
    }
    
}

#Preview {
    CheckoutScreen()
}
