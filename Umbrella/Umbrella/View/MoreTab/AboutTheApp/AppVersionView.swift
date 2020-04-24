//
//  AppVersionView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI

struct AppVersionView: View {
    var body: some View {
        ZStack {
            VStack{
                Text(Bundle.main.appName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    //.foregroundColor(Color.black)
                Image(systemName: "umbrella.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.blue)
                Text("Version: \(Bundle.main.shortVersion)")
                   // .foregroundColor(.black)
                Text("Build: \(Bundle.main.buildVersion)")
                 //   .foregroundColor(.black)
                Spacer()
            }.padding()
        }.navigationBarTitle(Text(MoreListItems.appVersion.rawValue.titleCase()).bold(),displayMode: .inline)
    }
}

struct AppVersionView_Previews: PreviewProvider {
    static var previews: some View {
        AppVersionView()
    }
}
