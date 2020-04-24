//
//  TabModel.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
// MARK:- Home Tab
struct HomeTab: View {
    @State var userLoginState: Bool = false
    var body: some View {
        ZStack{
            if userLoginState {
                HomeView()
            } else {
                AuthenticationView()
            }
        }.animation(.spring())
            .onAppear {
                self.checkLoginState()
                NotificationCenter.default.addObserver(forName: .logInStateChanged, object: nil, queue: .main) { (_) in
                    self.checkLoginState()
                }
        }
    }
    private func checkLoginState(){
        self.userLoginState = UserDefaults.standard.getLoginState()
    }
}
// MARK:- Group Tab
struct GroupTab: View {
    var body: some View {
        Text("Group View")
    }
}
// MARK:- Report Tab
struct ReportTab: View {
    var body: some View {
        Text("Report View")
    }
}
// MARK:- Admin Tab
struct AdminTab: View{
    var body: some View{
        Text("Admin Tab")
    }
}
// MARK:- More Tab
struct MoreTab: View {
    var body: some View {
        MoreView()
    }
}
