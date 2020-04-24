//
//  Buttons.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
// MARK:- All buttons in the APP
enum APPButtons: String{
    case signUp
    case logIn
    case cancel
    case forgetPassword
    case sendFeedback
    case update
    var title: String {
        return self.rawValue.titleCase()
    }
    var image: String {
        switch self{
        case .signUp: return "person.badge.plus.fill"
        case .logIn: return "person.crop.circle.fill"
        case .cancel: return "xmark.circle.fill"
        case .forgetPassword: return "bag.fill.badge.plus"
        case .sendFeedback: return "envelope.fill"
        case .update: return "doc.richtext"
        }
    }
    var backgroundColor: LinearGradient{
        return LinearGradient(gradient: Gradient(colors: [.green, .blue,.green]), startPoint: .leading, endPoint: .trailing)
    }
}
