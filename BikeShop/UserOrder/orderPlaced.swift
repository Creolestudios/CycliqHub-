//
//  orderPlaced.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 12/01/24.
//

import SwiftUI

struct orderPlaced: View {
    @State var tab:Bool = false;
    var body: some View {
            ZStack{
                Color("shoppingBack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    Spacer()
                    Image(systemName: "truck.box.fill")
                        .resizable()
                        .frame(width:150,height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Text("Order Successfully Placed")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                
            }
            .navigationBarItems(leading:Header)
        .toolbar(.hidden,for:.tabBar)
    }
    
        var Header:some View{
            HStack{
                NavigationLink {
                    customTabview().navigationBarBackButtonHidden(true)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"),Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                        )
                        .frame(width: 40,height: 40)
                        .shadow(color:.black,radius: 10)
                        .overlay(alignment:.center,content:
                                    {
                            Image(systemName: "house")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        )
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
    orderPlaced()
}
