//
//  MoreView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI

struct MoreView: View {
    private let authManager = FirebaseAuthManager.shared
    @ObservedObject var moreTableViewModel = MoreTableViewModel()
    @State var list: [MoreListSection] = []
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
            self.loadMoreList()
            NotificationCenter.default.addObserver(forName: .logInStateChanged, object: nil, queue: .main) { (_) in
                self.loadMoreList()
            }
        }
        
    }
    private func loadMoreList(){
        switch authManager.currentUserProfile.userType {
        case .owner, .superUser:
            self.list = [self.moreTableViewModel.myAccountSection,
                         self.moreTableViewModel.adminSection,
                         self.moreTableViewModel.aboutTheAppSection
            ]
        case .unknown, .user:
            self.list = [self.moreTableViewModel.myAccountSection,
                         self.moreTableViewModel.aboutTheAppSection
            ]
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

