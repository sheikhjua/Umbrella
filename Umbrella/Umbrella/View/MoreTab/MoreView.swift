//
//  MoreView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI

struct MoreView: View {
    @State var list: [MoreListSection] = []
//    @State var isUserLoggedIn: Bool?
//    @State var userType: UserType?
    @State var userLogInState = UserDefaults.standard.getLoginState()
    
    var body: some View {
        NavigationView{
            List {
                ForEach(list) { item in
                    Section(header: Text(item.title.rawValue.titleCase()).bold().frame(height: 50)) {
                        ForEach(item.rows, id: \.id) { row in
                            MoreListItemView(row: row)
                        }
                    }
                }.navigationBarTitle(Text("More").bold(),displayMode: .inline)
            }
        }.onAppear {
            UITableView.appearance().tableFooterView = UIView()
            self.list = self.createMoreList()
            NotificationCenter.default.addObserver(forName: .logInStateChanged, object: nil, queue: .main) { (_) in
                self.list = self.createMoreList()
            }
        }
    }
    private func createMoreList()->[MoreListSection]{
        let myAccountSection = MoreListSection(title: .myAccount)
        let adminSection = MoreListSection(title: .adminMenu)
        let aboutMyApp = MoreListSection(title: .aboutTheApp)
        if adminSection.rows.isEmpty {
            return [myAccountSection, aboutMyApp]
        } else {
            return [myAccountSection, adminSection, aboutMyApp]
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}

struct MoreListItemView: View {
    var row: MoreListItem
    var body: some View {
        VStack{
            if row.shouldNavigate {
                NavigationLink(destination: row.targetView){
                    Text(row.title.rawValue.titleCase())
                        .foregroundColor(row.title.textColor)
                }.navigationBarTitle("")
            } else {
                Text(row.title.rawValue.titleCase())
                    .foregroundColor(row.title.textColor)
                    .onTapGesture {
                    UserDefaults.standard.set(false, forKey: "logInState")
                        NotificationCenter.default.post(name: .logInStateChanged, object: nil)
                }
            }
        }
    }
}

