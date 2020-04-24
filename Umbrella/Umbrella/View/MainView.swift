//
//  MainView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI

struct MainView: View {
    @State var tag: Int = 0
    var body: some View {
        TabView(selection: $tag){
            HomeTab()
                .tabItem {
                    Image(systemName: APPTabs.home.selectedImage)
                        .font(.title)
                    Text(APPTabs.home.title)
            }.tag(APPTabs.home.tag)
            if UserDefaults.standard.getUserType() == .owner || UserDefaults.standard.getUserType() == .superUser{
                AdminTab()
                    .tabItem {
                        Image(systemName: APPTabs.admin.selectedImage)
                        .font(.title)
                        Text(APPTabs.admin.title)
                }.tag(APPTabs.admin.tag)
                GroupTab()
                    .tabItem {
                        Image(systemName: APPTabs.group.selectedImage)
                        .font(.title)
                        Text(APPTabs.group.title)
                }.tag(APPTabs.group.tag)
            }
            ReportTab()
                .tabItem {
                    Image(systemName: APPTabs.report.selectedImage)
                    .font(.title)
                    Text(APPTabs.report.title)
            }.tag(APPTabs.report.tag)
            MoreTab()
                .tabItem {
                    Image(systemName: APPTabs.more.selectedImage)
                    .font(.title)
                    Text(APPTabs.more.title)
            }.tag(APPTabs.more.tag)
        }//.accentColor(Color.blue)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
