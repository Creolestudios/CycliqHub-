//
//  demo.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 06/01/24.
//

import SwiftUI

struct Bikelist: View {
    let columns: [GridItem] = [
        GridItem(.flexible(),spacing: nil,alignment: nil),
        GridItem(.flexible(),spacing: nil,alignment: nil)
    ]
    let items = [
        bikeData(id: 1, name: "PEUGEOT - LR01", price: 30000,bikecategory:"Electric Bicycles",quantity: 0, image: "ElectricBike",isfavorite:false),
        bikeData(id: 5, name: "Leader Spyder", price: 30000,bikecategory:"Road Bike",quantity: 0, image: "71XSk",isfavorite:false),
        bikeData(id: 2, name: "SMITH - Trade", price: 1000,bikecategory:"Road Helmet",quantity: 0,image:"helmet",isfavorite:true),
        bikeData(id: 3,name: "SOLEX ACOUSTA", price: 10000,bikecategory:"Mountain Bikes",quantity: 0,image:"mikkelBech",isfavorite:true),
        bikeData(id: 4, name: "Leader Beast", price: 7000,bikecategory:"Road Bike",quantity: 0,image: "whiteBicycle",isfavorite:false)
    ]

    var body: some View {
        LazyVGrid(columns: columns,spacing: 10, content: {
                ForEach(items) { item in
                    CommonCardView(item: item)
                }
            })
    }
}

#Preview {
    Bikelist()
}



