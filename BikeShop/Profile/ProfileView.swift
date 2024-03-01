//
//  ProfileView.swift
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 08/01/24.
//

import SwiftUI

struct ProfileView: View {
    init() {
        UITextField.appearance().keyboardAppearance = .dark
    }
    @AppStorage("firstName") var firstName:String = ""
    @AppStorage("lastName") var lastName:String = ""
    @AppStorage("phoneNumber") var phoneNumber:String = ""
    @AppStorage("address") var address:String = ""
    @State var showingAlert:Bool = false;
    var body: some View {
        ZStack{
            Color("shoppingBack").ignoresSafeArea()
            ScrollView{
                VStack{
                    customTextInput(label: "First Name", placeHolder: "Enter First name", identifier: $firstName)
                    customTextInput(label: "Last Name", placeHolder: "Enter First name", identifier: $lastName)
                    customTextInput(label: "Phone Number", placeHolder: "Enter phone name", identifier: $phoneNumber)
                    customTextInput(label: "Address", placeHolder: "Enter Address", identifier: $address)
                        .padding(.bottom,10)
                    Button(action: {
                        if firstName.count > 0 && lastName.count > 0 && phoneNumber.count > 0 && address.count > 0  {
                            showingAlert.toggle()
                            UserDefaults.standard.setValue(firstName, forKey: "firstName")
                            UserDefaults.standard.setValue(lastName, forKey: "lastName")
                            UserDefaults.standard.setValue(phoneNumber, forKey: "phoneNumber")
                            UserDefaults.standard.setValue(address, forKey: "address")
                        }
                    }, label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth:.infinity)
                            .font(.title3)
                            .fontWeight(.bold)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"), Color("DarkBlue")]), startPoint: .leading, endPoint: .bottomTrailing))
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    })
                    Spacer()
                }
            }
            .alert("Detail saved", isPresented: $showingAlert) {
                Button("OK"){
                    showingAlert.toggle()
                }
            }
            .navigationBarItems(leading: customHeader(title: "My Profile",headerImage:"chevron.backward"))
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}
