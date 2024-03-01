//
//  HomeScreen.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 04/01/24.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var userCart:BikeViewModel
  
    var body: some View {
        NavigationView{
            ZStack(alignment:.bottomTrailing){
                Color("Colorblack").ignoresSafeArea()
                Image("back")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ScrollView{
                    VStack{
                        HStack{
                            Text("Choose Your Bike")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding()
                        ZStack(alignment:.center){
                            Image("ProductSvgback")
                                .resizable()
                                .aspectRatio(contentMode:.fit)
                                .overlay(alignment:.center,content: {
                                    TabView{
                                        VStack{
                                            Image("ElectricBike")
                                                .resizable()
                                                .padding(.top)
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.horizontal,30)
                                                .clipped()
                                        }
                                        VStack{
                                            Image("whiteBicycle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.horizontal,30)
                                        }
                                        VStack{
                                            Image("helmet")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .padding(.horizontal,30)
                                        }
                                    }
                                    .frame(height:300)
                                    .tabViewStyle(PageTabViewStyle())
                                })
                                .padding()
                        }
                        Bikelist()
                        Spacer()
                    }
                }
            }
        }
    }
}


struct bikeData: Identifiable {
    let id: Int
    let name: String
    let price:  Int
    let bikecategory:String
    var quantity:Int
    let image:String
    let isfavorite:Bool
}


struct CommonCardView: View {
    @State var item: bikeData
    @State var isSelected  = false
    var body: some View {
        NavigationLink {
            DetailView(bikeDetail:item)
                .navigationBarBackButtonHidden(true)
        } label: {
            VStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.5), Color("blackGrid")]), startPoint: .leading, endPoint: .trailing))
                        .overlay(alignment: .leading, content: {
                            VStack(alignment: .leading, spacing: 8) {
                                Image(systemName: "heart")
                                    .foregroundColor(isSelected ? Color("CustomColor") : Color.white)
                                    .font(.system(size: min(geometry.size.width / 8, 30)))
                                    .padding()
                                    .onTapGesture {
                                        isSelected.toggle()
                                    }

                                Image(item.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: min(geometry.size.width - 32, 150), height: min(geometry.size.height - 32, 100))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(item.bikecategory)
                                        .foregroundColor(.gray)

                                    Text(item.name)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)

                                    Text("\(item.price)")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                            }
                        })
                        .padding()
                }
            }
            .frame(width: 210, height: 300)
        }
        .onAppear(perform: {
            isSelected = item.isfavorite
        })
    }
}
#Preview {
    HomeScreen()
        
}
