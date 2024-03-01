//
//
//  BikeShop
//
//  Created by Nirmalsinh Rathod on 04/01/24.
//

import SwiftUI

struct ShoppingCart: View{
    @State var coupon:String = "";
    @State var isCouponValid:Bool = false;
    @State var showError:Bool = false;
    @EnvironmentObject var userCart:BikeViewModel
    @State var showCheck:Bool = false;
    @State var discountPercentage:Double = 0.0;
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View
    {
        NavigationView{
            ZStack{
                Color("shoppingBack").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    if userCart.userCart.count > 0 {
                        ScrollView{
                            VStack(spacing: 30)
                            {
                                ForEach(userCart.userCart) { item in
                                    CardView(bikeitem:item)
                                }
                                HStack{
                                    TextField(
                                        "Enter Coupon",
                                        text: $coupon
                                    )
                                    .padding()
                                    .frame(height: 45)
                                    .background(Color("Couponback").cornerRadius(8))
                                    .shadow(radius: 16,x:0,y:10)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"), Color("DarkBlue")]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                                        .overlay(content: {
                                            Text(isCouponValid ?  "Remove" : "Apply")
                                                .fontWeight(.bold)
                                                .font(.system(size: 15))
                                                .foregroundColor(.white)
                                        })
                                        .frame(width: 114,height: 44)
                                        .onTapGesture {
                                            isCouponValid ? removeCoupon() : applyCoupon()
                                        }
                                        .disabled(isValid())
                                }
                                if showError {
                                    Text("Please Enter Valid Coupon")
                                        .foregroundColor(Color.red)
                                }
                                VStack{
                                    Text("Your bag qualifies for free shipping")
                                        .foregroundColor(.gray)
                                        .font(.title3)
                                        .padding(.bottom)
                                    VStack(spacing:10){
                                        totalDetailView(title: "SubTotal:", amount: "\(userCart.userCartTotal)")
                                        totalDetailView(title: "Delivery Fee:", amount: "0")
                                        if isCouponValid{
                                            totalDetailView(title: "Discount:", amount: "\(discountPercentage)%")
                                        }
                                        totalDetailView(title: "Total:", amount: !isCouponValid ?  "₹ \(formatNumber(userCart.userCartTotal))" : "₹ \(discountedPrice)")
                                    }
                                }
                                NavigationLink {
                                    CheckoutScreen()
                                        .navigationBarBackButtonHidden(true)
                                } label: {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color("Couponback"))
                                        .frame(width: 150,height: 40)
                                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 16,x:0,y:10)
                                        .overlay(alignment: showCheck ? .trailing :  .leading) {
                                            if(showCheck)
                                            {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"),Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                                                    )
                                                    .frame(width: 40,height: 40)
                                                    .overlay(content:
                                                                {
                                                        Image(systemName: "chevron.forward" )
                                                            .foregroundColor(.white)
                                                    }
                                                    )
                                            }
                                            else
                                            {
                                                HStack{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(LinearGradient(gradient: Gradient(colors: [Color("CustomColor"),Color("DarkBlue")]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                                                        )
                                                        .frame(width: 40,height: 40)
                                                        .overlay(content:
                                                                    {
                                                            Image(systemName: "chevron.forward" )
                                                                .foregroundColor(.white)
                                                        }
                                                        )
                                                    
                                                    Text("Checkout").foregroundColor(.white.opacity(0.4))
                                                }
                                            }
                                        }
                                }
                            }
                            .padding(20)
                        }
                    }
                    else
                    {
                        VStack(alignment:.center){
                            Image("CartEmpty")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 140, height: 140)
                            Text("Ohhh... Your Cart is Empty")
                                .foregroundColor(.white)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                .navigationBarItems(leading: customHeader(title: "Cart", headerImage: "chevron.backward"))
                .toolbarBackground(Color("shoppingBack"),for: .navigationBar)
            }
        }
    }
    var discountedPrice: Double {
        let trans =  Double(userCart.userCartTotal)
        let discountAmount = trans * (discountPercentage / 100.0)
        return trans - discountAmount
    }
    func applyCoupon() {
        if(coupon == "Bike")
        {
            discountPercentage = 50.0
            isCouponValid = true
            showError = false
        }
        else if(coupon == "LUCKY30")
        {
            discountPercentage = 40.0
            isCouponValid = true
            showError = false
        }
        else
        {
            showError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                coupon = ""
                showError = false
            }
        }
      
    }
    func removeCoupon()
    {
        coupon = ""
        isCouponValid = false
        discountPercentage = 0.0
        showError = false
    }
    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
    
    func isValid() -> Bool{
        if(coupon.count > 0 && userCart.userCartTotal > 0)
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    
}

struct totalDetailView : View {
    let title:String
    let amount:String
    var body: some View {
        HStack{
            Text("\(title)")
                .foregroundColor(Color.white)
                .font(.title3)
            Spacer()
            Text("\(amount)")
                .foregroundColor(title == "Total:" ? Color("CustomColor") : Color.white.opacity(0.4))
                .font(title == "Total:" ? .title2 : .headline)
                .fontWeight(.bold)
        }
    }
}

struct CardView:View {
    var bikeitem:bikeData
    @EnvironmentObject var userCart:BikeViewModel
    var body:some View{
        HStack{
            Image("productBack")
                .resizable()
                .frame(width: 129,height: 150)
                .overlay(
                    Image(bikeitem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80,height: 70)
                )
            VStack(alignment:.leading){
                Text("\(bikeitem.name)")
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                HStack{
                    Text("\(bikeitem.price)")
                        .foregroundColor(Color("CustomColor"))
                    Spacer()
                    HStack{
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 24,height: 24)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .overlay {
                                Image(systemName:"plus")
                                    .foregroundColor(Color.white)
                                    .onTapGesture {
                                        userCart.incrementQuantity(itemId: bikeitem.id, quantityCount: bikeitem.quantity,itemPrice: bikeitem.price)
                                    }
                            }
                        Text("\(bikeitem.quantity)")
                            .foregroundColor(Color.white)
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.gray)
                            .frame(width: 24,height: 24)
                            .overlay {
                                Image(systemName:"minus")
                                    .foregroundColor(Color.white)
                            }
                            .onTapGesture {
                                if bikeitem.quantity == 1
                                {
                                    userCart.removeItem(itemId: bikeitem.id,itemPrice: bikeitem.price)
                                }
                                else
                                {
                                    userCart.decrementQuantity(itemId: bikeitem.id, quantityCount: bikeitem.quantity,itemPrice: bikeitem.price)
                                }
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    ShoppingCart()
}

