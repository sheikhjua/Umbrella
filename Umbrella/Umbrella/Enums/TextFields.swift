//
//  TextFields.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
enum APPTextFields: String {
    case firstName
    case lastName
    case emailAddress
    case password
    case confirmPassword
    case phoneNumber
    case passwordAndConfirmPasswordShouldEqual
    var name: String{
        return self.rawValue.titleCase()
    }
}
