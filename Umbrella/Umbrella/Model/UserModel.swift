//
//  UserModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
// MARK: - LogInStates
enum LoginState{
    case fullLoggedIn
    case partialLoggedIn
    case notLoggedIn
    case expiredLoggedIn
    case unknown
}
// MARK:- UserLoginState class
class UserLoginState: ObservableObject{
    @Published var loginState: LoginState = .unknown
}
// MARK: - User Type
enum UserType: String{
    case owner
    case superUser
    case user
    case unknown
//    var background: LinearGradient{
//        switch self {
//        case .owner: return gradient
//        case .superUser: return gradient
//        case .user: return gradient
//        case .unknown: return gradient
//        }
//    }
}
// MARK: - Network status
enum NetworkStatus{
    case wifi
    case mobileData
    case notConnected
    case unknown
}
//MARK: - Subsription type
enum SubscriptionType{
    case trial
    case paid
    case free
    case unknown
}
//MARK: - User
struct User: Identifiable{
    let id = UUID()
    let userID: String?
    let firstName: String?
    let lastName: String?
    let emailAddress: String?
    let mobileNumber: String?
    let userType: UserType?
    let imageURL: String?
    init ( userID: String? = nil,
           firstName: String? = nil,
           lastName: String? = nil,
           emailAddress: String? = nil,
           mobileNumber: String? = nil,
           userType: UserType? = nil,
           image: String? = nil
        
    ){
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.mobileNumber = mobileNumber
        self.userType = userType
        self.imageURL = image
    }
    
}
// MARK:- Login Info
struct LoginInfo{
    let email: String
    let password: String
}
// MARK:- UserProfile
struct UserProfile{
    var userID: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    var phoneNumber: String? = nil
    var profileImage: UIImage? = nil
    var userType: UserType = .unknown
}
//MARK: - Location
struct Location: Identifiable{
    let id = UUID()
    let latitude: Double
    let longitude: Double
}
//MARK: - User locations
struct UserLocation: Identifiable{
    let id = UUID()
    let userID: String
    let location: Location
    let locationName : String
    let date: String
}
//MARK: - Group
struct Group: Identifiable{
    let id = UUID()
    let groupID: String
    let userID: [String]
    let groupName: String
    let admin: User
}
