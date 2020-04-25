//
//  MoreModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
// MARK:- More List for more tab
struct MoreList: Identifiable{
    var id = UUID()
    var title: String
    var section: [MoreListSection]
}
// MARK:- More List Section
struct MoreListSection: Identifiable{
    var id = UUID()
    var title: MoreListSections = .aboutTheApp
    var rows: [MoreListItem] = []
}
// MARK:- More List Item
struct MoreListItem: Identifiable{
    var id = UUID()
    var title: MoreListItems
    var shouldNavigate: Bool = true
    var targetView: AnyView = AnyView(EmptyView())
}
// MARK:- Static title for More Sections
enum MoreListSections: String {
    case myAccount
    case adminMenu
    case aboutTheApp
}
// MARK:- Static title for More Items(rows)
enum MoreListItems: String{
    case logIn
    case signUp
    case logOut
    case manageProfile
    case manageGroups
    case managePlaces
    case userHistory
    case manageUsers
    case appFeedback
    case aboutTheApp
    case appVersion
//    var view: AnyView {
//        switch self{
//        case .aboutTheApp: return AnyView( AboutTheAppView())
//        case .appFeedback: return AnyView(AppFeedbackView())
//        case .appVersion: return AnyView(AppVersionView())
//        case .manageProfile: return AnyView(ProfileView())
//        default: return AnyView(AboutTheAppView())
//        }
//    }
    var textColor: Color?{
        switch self{
        case .logOut: return .red
        default: return nil
        }
    }
}
