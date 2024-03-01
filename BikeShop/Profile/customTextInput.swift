//
//  customTextInput.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 12/01/24.
//

import SwiftUI

struct customTextInput: View {
    let label:String
    var placeHolder:String
    let identifier:Binding<String>
    var body: some View
    {
        VStack{
            Text("\(label)")
                .foregroundColor(.white)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment:.leading)
                .font(.title3)
            if label == "Address"
            {
                TextField(
                    placeHolder,
                    text: identifier, axis: .vertical
                )
                .lineLimit(5...10)
                .padding()
                .background(Color("Couponback").cornerRadius(8))
                .shadow(radius: 16,x:0,y:10)
                .foregroundColor(.white)
                .font(.headline)
            }
            else
            {
                TextField(
                    placeHolder,
                    text: identifier
                )
                .padding()
                .background(Color("Couponback").cornerRadius(8))
                .shadow(radius: 16,x:0,y:10)
                .foregroundColor(.white)
                .font(.headline)
            }
        }
    }
}

struct customTextInput_Previews: PreviewProvider {
    @State static private var previewIdentifier: String = "Preview Text"
    
    static var previews: some View {
        customTextInput(label: "Address", placeHolder: "Enter Address", identifier: $previewIdentifier)
    }
}
