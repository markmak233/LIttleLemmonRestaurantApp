//
//  ProfileView.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-25.
//

import SwiftUI

struct ProfileView:View {
    
    @StateObject private var viewModel = Profile()
    
    @Environment(\.presentationMode) var presentation
    
    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    
    @State private var isLogOut = false
    
    var body:some View{
        ScrollView(.vertical){
            NavigationLink(destination: Onboarding(), isActive: $isLogOut){ }
            Text("Avator").InputTextHintStyle()
            HStack{
                Image("Profile").resizable().aspectRatio( contentMode: .fit)
                    .frame(maxHeight: 75).clipShape(Circle()).padding(.trailing)
                Button("Change") {}.buttonStyle(GreenButtonStyle())
                Button("Remove"){}.buttonStyle(CancelButtonStyle())
            }.padding()
//            name space
            Text("FirstName").InputTextHintStyle()
            TextField("FirstName",text: $firstName)
            
            Text("LastName").InputTextHintStyle()
            TextField("LastName",text: $lastName)
            
            Text("email").InputTextHintStyle()
            TextField("email",text: $email)
            
            Text("phone number").InputTextHintStyle()
            TextField("number",text: $phoneNumber)
            
            if viewModel.errorMessageShow {
                withAnimation() {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
//            selection
            Text("Email Notiification")
            VStack{
                Toggle("Order statuses", isOn: $orderStatuses).toggleStyle(CheckBoxStyle())
                Toggle("Password changes", isOn: $passwordChanges).toggleStyle(CheckBoxStyle())
                Toggle("Special offers", isOn: $specialOffers).toggleStyle(CheckBoxStyle())
                Toggle("Newsletter", isOn: $newsletter).toggleStyle(CheckBoxStyle())
                
            }
//            buttons
            Button("Log Out"){
                UserDefaults.standard.set(false, forKey: IsLoggedIn)
                UserDefaults.standard.set("", forKey: logInLastName)
                UserDefaults.standard.set("", forKey: logInFirstName)
                UserDefaults.standard.set("", forKey: logInEmail)
                UserDefaults.standard.set(true, forKey: AccountOrderStatuses)
                UserDefaults.standard.set(true, forKey: AccountPasswordChanges)
                UserDefaults.standard.set(true, forKey: AccountSpecialOffers)
                UserDefaults.standard.set(true, forKey: AccountNewsletter)
                isLogOut = true
                
            }.padding(.vertical).buttonStyle(YellowButtonStyle())
            HStack{
                Button("Discard Changes"){
                    firstName = viewModel.firstName
                    lastName = viewModel.lastName
                    email = viewModel.email
                    phoneNumber = ""
                    
                    orderStatuses = viewModel.orderStatuses
                    passwordChanges = viewModel.passwordChanges
                    specialOffers = viewModel.specialOffers
                    newsletter = viewModel.newsletter
                    self.presentation.wrappedValue.dismiss()
                    
                }.padding(.horizontal).buttonStyle(GreenButtonStyle())
                Button("Save Changes"){
                    if viewModel.validateUserInput(firstName: firstName, lastName: lastName, email: email) {
                        UserDefaults.standard.set(firstName, forKey: logInFirstName)
                        UserDefaults.standard.set(lastName, forKey: logInLastName)
                        UserDefaults.standard.set(email, forKey: email)
                        UserDefaults.standard.set(orderStatuses, forKey: AccountOrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: AccountPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: AccountSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: AccountNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                }
                        .padding(.horizontal)
                        .buttonStyle(CancelButtonStyle())
            }
        }.padding()
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
            phoneNumber = ""
            
            orderStatuses = viewModel.orderStatuses
            passwordChanges = viewModel.passwordChanges
            specialOffers = viewModel.specialOffers
            newsletter = viewModel.newsletter
        }
        .navigationTitle(Text("Personal information"))
        .navigationBarTitleDisplayMode(.inline)
    }

}

#Preview {
    ProfileView()
}


