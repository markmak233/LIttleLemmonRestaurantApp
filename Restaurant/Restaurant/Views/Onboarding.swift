//
//  Onboarding.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import SwiftUI

struct Onboarding: View {
    @StateObject var profileModel = Profile()
    
    @State var afirstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    
    @State var isLogIn = false
    @State var isKeyboardVisible = false
    @State var contentOffset:CGSize = .zero
    
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack{
//                    header
                    VStack{
                        Spacer()
                        Image("Logo")
                        Spacer()
                        Header()
                        Spacer().padding()
                    }.background(.color1)
                    VStack{
//                        fill in form
                        NavigationLink(destination: Home(), isActive: $isLogIn){}
                        Text("First Name").InputTextHintStyle()
                        TextField("First Name", text: $afirstName)
                        Text("Last Name").InputTextHintStyle()
                        TextField("Last Name", text: $lastName)
                        Text("Email").InputTextHintStyle()
                        TextField("Email", text: $email).keyboardType(.emailAddress)
                        
                    }.padding()
//                    if there is error contains
                    if profileModel.errorMessageShow{
                        withAnimation(){
                            Text(profileModel.errorMessage).foregroundColor(.red)
                                .padding()
                        }
                    }
                    
                    Spacer()
//                    submit button
                    VStack{
                        Button("Register"){
                            if profileModel.validateUserInput(firstName: afirstName, lastName: lastName, email: email) {
                                UserDefaults.standard.set(afirstName, forKey: logInFirstName)
                                UserDefaults.standard.set(lastName, forKey: logInLastName)
                                UserDefaults.standard.set(email, forKey: logInEmail)
                                UserDefaults.standard.set(true, forKey: IsLoggedIn)
                                UserDefaults.standard.set(true, forKey: AccountOrderStatuses)
                                UserDefaults.standard.set(true, forKey: AccountPasswordChanges)
                                UserDefaults.standard.set(true, forKey: AccountSpecialOffers)
                                UserDefaults.standard.set(true, forKey: AccountNewsletter)
                                afirstName = ""
                                lastName = ""
                                email = ""
                                isLogIn = true
                            }
                        }.buttonStyle(YellowButtonStyle())
                    }.padding()
                    Spacer()
                }
                
                .offset(y:14)
//                keyboard settings
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    withAnimation {
                        let keyboardRect = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                        let keyboardHeight = keyboardRect.height
                        self.isKeyboardVisible = true
                        self.contentOffset = CGSize(width: 0, height: -keyboardHeight / 2 + 50)
                    }
                    
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                    withAnimation {
                        self.isKeyboardVisible = false
                        self.contentOffset = .zero
                    }
                }
                
                
            }.onAppear() {
                if UserDefaults.standard.bool(forKey: IsLoggedIn) {
                    isLogIn = true
                }
            }
        }.navigationBarBackButtonHidden()

    }
    
    
}

#Preview {
    Onboarding()
}
