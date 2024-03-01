//
//  DetailView.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 04/01/24.
//

import SwiftUI


struct DetailView: View {
    @EnvironmentObject var userCart:BikeViewModel
    @State var showDescription:Bool = false
    @State var navigateToHomeScreen:Bool = false
    @State var isuserContain:Bool = false;
    @Environment(\.presentationMode) var presentationMode
    @State var bikeDetail: bikeData
    @State private var navigateToHome = false
    @State  var showingAlert = false
    @State var tab:Bool = false;
    @State var count: Int = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("shoppingBack").ignoresSafeArea()
                Image("back")
                    .resizable()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack{
                    
                    ItemViewContainer
                }
                
            }
            .navigationBarItems(leading: Header)
            .navigationBarTitleDisplayMode(.inline)        }
        .alert(isuserContain ? "Removed From Cart" : "Added to Cart", isPresented: $showingAlert) {
            Button("OK"){
                navigateToHome = true
            }
        }
        .background(
              NavigationLink(
                destination: HomeScreen().navigationBarBackButtonHidden(true),
                  isActive: $navigateToHome
              ) {
                  HomeScreen().navigationBarBackButtonHidden(true)
              }
          )
        .onAppear(perform: {
            let containProduct =  userCart.userCart.contains { item in
                return item.name == bikeDetail.name
            }
            isuserContain = containProduct ?  true : false
        })
        .onDisappear(perform: {
            tab.toggle()
        })
        .toolbar(tab ? .visible : .hidden,for:.tabBar)
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
                    Image(systemName: showDescription ?  "chevron.down":"chevron.backward" )
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                )
                .onTapGesture {
                    showDescription ? withAnimation(.default){
                        showDescription.toggle()
                    }  : presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("\(bikeDetail.name)")
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundColor(Color.white)
            Spacer()
        }
    }
    var ItemViewContainer: some View{
        VStack{
            Spacer()
            Image("\(bikeDetail.image)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: showDescription ? 290: .infinity,height:showDescription ? 240: 290)
            Spacer()
            VStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("blackGrid"), Color("Colorblack")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                    .frame(width: .infinity,height: !showDescription ? 100:450 )
                    .overlay(alignment:.top,content: {
                        VStack(alignment:.leading){
                            HStack(alignment:.center){
                                Spacer()
                                Button(action: {
                                    withAnimation(.default)
                                    {
                                        showDescription.toggle()
                                    }
                                }, label: {
                                    Text("Description")
                                        .shadow(color:.white.opacity(0.5),radius: 10,y:10)
                                        .frame(maxWidth:.infinity)
                                        .padding()
                                        .background(Color("Couponback"))
                                        .cornerRadius(15)
                                        .foregroundColor(showDescription ? Color("CustomColor"): .gray)
                                    
                                })
                                Spacer()
                                Spacer()
                            }
                            if showDescription {
                                DesCriptionView
                            }
                        }
                        .padding()
                        
                    })
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    var DesCriptionView: some View{
        ScrollView{
            VStack(alignment:.leading){
                Text("\(bikeDetail.name)")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("The \(bikeDetail.name) uses the same design as the most iconic bicycle. 130-year history and combines it with agile, dynamic performance that's perfectly suited to navigating today's cities. As well as a lugged steel frame and iconic design, this city bike also features a 16-speed Shimano Claris drivetrain.")
                    .fontWeight(.thin)
                    .foregroundColor(Color.white)
                Spacer()
                HStack{
                    Text("₹ \(bikeDetail.price)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("CustomColor"))
                    Spacer()
                    Text(isuserContain ? "Remove From Cart": "Add to Cart")
                        .padding()
                        .font(.headline)
                        .fontWeight(.bold)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"), Color("DarkBlue")]), startPoint: .leading, endPoint: .bottomTrailing))
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                        .onTapGesture {
                            if isuserContain
                            {
                                userCart.removeItem(itemId: bikeDetail.id, itemPrice: bikeDetail.price)
                                showingAlert.toggle()
                            }
                            else
                            {
                                userCart.addtoCart(item: bikeDetail)
                                showingAlert.toggle()
                            }
                        }
                }
            }
            .padding()
        }
        
        
    }
}


#Preview {
    DetailView(bikeDetail: bikeData(id: 1, name: "Demo", price: 1000, bikecategory: "Sample Category", quantity: 0, image: "sampleImage", isfavorite: false))
    
}
