//
//  UserDefaults.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
import CoreLocation
import CommonCrypto

extension UserDefaults{
    // MARK:- Login State
    func getLoginState()->Bool{
        var state = false
        if let loginState = self.value(forKey: "logInState") as? Bool{
            state = loginState
        }
        return state
    }
    func setLogInState(state: Bool){
        self.set(state, forKey: "logInState")
        NotificationCenter.default.post(name: .logInStateChanged, object: nil)
    }
    
    // MARK:- User details changed
    func getProfileChanged()->Bool{
        var state = false
        if let loginState = self.value(forKey: "userProfile") as? Bool{
            state = loginState
        }
        return state
    }
    func setProfileChanged(status: Bool){
        self.set(status, forKey: "userProfile")
        NotificationCenter.default.post(name: .profileChanged, object: nil)
    }
    
    // MARK:- Switch View changed
    func getView()->String{
        var view = ""
        if let switchView = self.value(forKey: "switchView") as? String{
            view = switchView
        }
        return view
    }
    func setView(view: String){
        self.set(view, forKey: "switchView")
        NotificationCenter.default.post(name: NSNotification.Name("switchViewChanged"),object: nil)
    }
    // MARK:- Location permission status not permitted
    func getLocationPermission()->Bool{
        var status = false
        if let permissionStatus = self.value(forKey: "locationPermission") as? Bool {
            status = permissionStatus
        }
        return status
    }
    func setLocationPermission(status: Bool){
        self.set(status, forKey: "locationPermission")
        NotificationCenter.default.post(name: .locationAuthorizationStatusChanged, object: nil)
    }
    // MARK:- User Type
    func getUserType()->UserType{
        return .user
    }
}

