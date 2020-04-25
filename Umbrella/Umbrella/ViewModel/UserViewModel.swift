//
//  UserViewModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI

class UserViewModel: NSObject, ObservableObject{
    private let authManager = FirebaseAuthManager.shared
    @Published var userFirstName: String = ""
    @Published var userLastName: String = ""
    @Published var userPhoneNumber: String = ""
    @Published var image: UIImage = UIImage(systemName: "person")!
    @Published var isDataLoaded: Bool = false
    override init(){
        super.init()
        if authManager.loginState{
            loadUserProfile()
        } else {
            print("login state: \(authManager.loginState)")
        }
        NotificationCenter.default.addObserver(forName: .profileChanged, object: nil, queue: .main) { (_) in
            if let _ = self.authManager.currentUserProfile.userID{
                self.loadUserProfile()
            }
        }
    }
    private func loadUserProfile(){
        let userProfile = authManager.currentUserProfile
        self.userFirstName = userProfile.firstName  ?? ""
        self.userLastName = userProfile.lastName ?? ""
        self.userPhoneNumber = userProfile.phoneNumber ?? ""
        self.image = userProfile.profileImage ?? UIImage(systemName: "person.fill")!
        self.isDataLoaded = true
    }
}
