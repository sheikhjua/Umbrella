//
//  Notification+extention.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
enum NotificationNames: String{
    case profileChanged
    case logInStateChanged
    case appStateChanged
    case locationAuthorizationStatusChanged
    case applicationRegainStatusChanged
    case loadingStarted
    case loadingCompleted
}
extension Notification.Name {
    static let profileChanged = Notification.Name(NotificationNames.profileChanged.rawValue)
    static let logInStateChanged = Notification.Name(NotificationNames.logInStateChanged.rawValue)
    static let appStateChanged = Notification.Name(NotificationNames.appStateChanged.rawValue)
    static let locationAuthorizationStatusChanged = Notification.Name(NotificationNames.locationAuthorizationStatusChanged.rawValue)
    static let applicationRegainStatusChanged = Notification.Name(NotificationNames.applicationRegainStatusChanged.rawValue)
    static let loadingStarted = Notification.Name(NotificationNames.loadingStarted.rawValue)
    static let loadingCompleted = Notification.Name(NotificationNames.loadingCompleted.rawValue)
}
