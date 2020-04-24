//
//  AboutTheAppView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//


import SwiftUI
import Combine

struct AboutTheAppView: View {
    var body: some View {
        ZStack{
            VStack{
                Text("Jerin Tel Inc. © \(Date().getYear())")
                    //.foregroundColor(Color.black)
                    .bold()
                Spacer()
            }.padding()
        }.navigationBarTitle(Text(MoreListItems.aboutTheApp.rawValue.titleCase()).bold(),displayMode: .inline)
    }
}

struct AboutTheAppView_Previews: PreviewProvider {
    static var previews: some View {
        AboutTheAppView()
    }
}
