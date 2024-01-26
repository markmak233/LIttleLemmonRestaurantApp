//
//  Profile.swift
//  Restaurant
//
//  Created by marco mai on 2024-01-23.
//

import Foundation

public let logInFirstName = "a"
public let logInLastName = "a"
public let logInEmail = "a@a.com"

public let IsLoggedIn = "kIsLoggedIn"

public let AccountOrderStatuses = "order statuses key"
public let AccountPasswordChanges = "password changes key"
public let AccountSpecialOffers = "special offers key"
public let AccountNewsletter = "news letter key"

class Profile: ObservableObject{
    @Published var firstName = UserDefaults.standard.string(forKey: logInFirstName) ?? ""
    @Published var lastName = UserDefaults.standard.string(forKey: logInLastName) ?? ""
    @Published var email = UserDefaults.standard.string(forKey: logInEmail) ?? ""
    
    @Published var orderStatuses = UserDefaults.standard.bool(forKey: AccountOrderStatuses)
    @Published var passwordChanges = UserDefaults.standard.bool(forKey: AccountPasswordChanges)
    @Published var specialOffers = UserDefaults.standard.bool(forKey: AccountSpecialOffers)
    @Published var newsletter = UserDefaults.standard.bool(forKey: AccountNewsletter)
    
    @Published var errorMessage = ""
    @Published var errorMessageShow = false
    @Published var isLogin = "not log in"
   
    
    func validateUserInput(firstName: String, lastName: String, email: String ) -> Bool {
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty else {
            errorMessage = "All fields are required"
            errorMessageShow = true
            return false
        }
        
        guard email.contains("@") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        let email = email.split(separator: "@")
        
        guard email.count == 2 else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        guard email[1].contains(".") else {
            errorMessage = "Invalid email address"
            errorMessageShow = true
            return false
        }
        
        errorMessageShow = false
        errorMessage = ""
        return true
    }

}
