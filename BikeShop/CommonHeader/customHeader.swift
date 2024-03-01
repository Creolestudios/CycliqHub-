//
//  customHeader.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 12/01/24.
//

import SwiftUI

struct customHeader: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userCart:BikeViewModel
    let title:String
    let headerImage:String
    var body: some View {
            HStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"),Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                    )
                    .frame(width: 40,height: 40)
                    .shadow(color:.black,radius: 10)
                    .overlay(alignment:.center,content:
                                {
                        Image(systemName: headerImage)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    )
                    .onTapGesture {
                        if title == "My Profile" || title == "Cart"
                        {
                            if let index = userCart.tabStack.firstIndex(of: userCart.selectedTab) {
                                userCart.tabStack.remove(at: index)
                            }
                            userCart.selectedTab =  userCart.tabStack.last ?? 0
                        }
                        else
                        {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                Spacer()
                Text("\(title)")
                    .padding(.horizontal,10)
                    .fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(Color.white)
                Spacer()
        }
    }
}

#Preview {
    customHeader(title:"",headerImage:"chevron.backward")
}
