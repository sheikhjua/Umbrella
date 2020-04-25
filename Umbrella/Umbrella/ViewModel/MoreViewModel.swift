//
//  MoreViewModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
class MoreTableViewModel: NSObject, ObservableObject{
    @Published var myAccountSection: MoreListSection = MoreListSection()
    @Published var adminSection: MoreListSection = MoreListSection()
    @Published var aboutTheAppSection: MoreListSection = MoreListSection()
    override init() {
        super.init()
        let loginState = UserDefaults.standard.getLoginState()
        self.makeMoreList(forLoginState: loginState)
        NotificationCenter.default.addObserver(forName: .logInStateChanged, object: nil, queue: .main) { (_) in
            let loginState = UserDefaults.standard.getLoginState()
            self.makeMoreList(forLoginState: loginState)
        }
    }
    private func makeMoreList(forLoginState: Bool){
        let userType = FirebaseAuthManager.shared.currentUserProfile.userType
        self.myAccountSection = createMyAccountSection(forLoginState: forLoginState)
        self.adminSection = createAdminSection(forUserType: userType)
        self.aboutTheAppSection = createAboutTheAppSection()
    }
    private func createMyAccountSection(forLoginState: Bool)->MoreListSection{
        var rows: [MoreListItem]
        switch forLoginState{
        case true:
            rows = [.init(title: .logOut, shouldNavigate: false),
                    .init(title: .manageProfile, targetView: AnyView(ProfileView()))
            ]
        case false:
            rows = [.init(title: .logIn, targetView: AnyView(LogInView())),
                    .init(title: .signUp, targetView: AnyView(SignUpView()))
            ]
        }
        return MoreListSection(title: .myAccount, rows: rows)
    }
    private func createAdminSection(forUserType: UserType)->MoreListSection{
        var rows: [MoreListItem]
        switch forUserType{
        case .owner, .superUser:
            rows = [.init(title: .manageGroups),
                    .init(title: .manageUsers),
                    .init(title: .managePlaces)
            ]
        case .user, .unknown:
            rows = []
        }
        return MoreListSection(title: .adminMenu, rows: rows)
    }
    private func createAboutTheAppSection()->MoreListSection{
        var rows: [MoreListItem]
        rows = [.init(title: .appFeedback,targetView: AnyView(AppFeedbackView())),
                .init(title: .aboutTheApp, targetView: AnyView(AboutTheAppView())),
                .init(title: .appVersion, targetView: AnyView(AppVersionView()))
            ]
        return MoreListSection(title: .aboutTheApp, rows: rows)
    }
}
