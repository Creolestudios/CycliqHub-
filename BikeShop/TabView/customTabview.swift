//
//  customTabview.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 08/01/24.
//

import SwiftUI

class BikeViewModel:ObservableObject{
    @Published var userCart:[bikeData] = []
    @Published var userCartTotal:Int = 0;
    @Published var selectedTab: Int = 0;
    @Published var tabStack:[Int] = [0]
    func addtoCart(item:bikeData)
    {
        var result = item
        result.quantity  = item.quantity + 1
        userCart.append(result)
        userCartTotal += result.price
    }
    func incrementQuantity(itemId:Int,quantityCount:Int,itemPrice:Int)
    {
        userCart.indices.forEach { index in
            if userCart[index].id == itemId {
                userCart[index].quantity += 1
                userCartTotal += itemPrice
            }
        }
    }
    func decrementQuantity(itemId:Int,quantityCount:Int,itemPrice:Int)
    {
        userCart.indices.forEach { index in
            if userCart[index].id == itemId {
                userCart[index].quantity -= 1
                userCartTotal -= itemPrice
            }
        }
    }
    
    func removeItem(itemId:Int,itemPrice:Int)
    {
        userCart.removeAll { $0.id == itemId }
        userCartTotal -= itemPrice
    }
    
}
struct customTabview: View {
    @StateObject var userCartData:BikeViewModel = BikeViewModel()
    var body: some View {
        NavigationView{
            TabView(selection: $userCartData.selectedTab){
                Group{
                    HomeScreen()
                        .tabItem {
                            Image(systemName: "bicycle")
                            Text("Home")
                        }
                        .tag(0)
                    ShoppingCart()
                        .tabItem {
                            Image(systemName: "cart")
                            Text("Cart")
                        }
                        .tag(1)
                    NavigationView{
                        ProfileView()
                    }
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
                }
                .toolbarBackground(Color("Colorblack"), for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
            .onChange(of: userCartData.selectedTab) { newTab in
                if !userCartData.tabStack.contains(newTab) {
                    userCartData.tabStack.append(newTab)
                }
            }
            .onAppear {
                userCartData.selectedTab = 0
            }
        }
        .environmentObject(userCartData)
    }
}

#Preview {
    customTabview()
}
