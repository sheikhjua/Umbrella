//
//  AuthenticationView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
// MARK:- Authentication View
struct AuthenticationView: View {
    @Environment(\.presentationMode) var presentation
    @State var selection: Int? = nil
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                Spacer()
                //SignUpButton()
                NavigationLink(destination: SignUpView(), tag: 1, selection: $selection){
                    Button(action: {
                        self.selection = 1
                    }) {
                        FlexibleLabelWithImage(button: .signUp)
                    }.overlay(RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                }
                //LogInButton()
                NavigationLink(destination: LogInView(), tag: 2, selection: $selection){
                    Button(action: {
                        self.selection = 2
                    }) {
                        FlexibleLabelWithImage(button: .logIn)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.gray, lineWidth: 1)
                    )
                }
                Spacer()
                    .frame(height: 20)
            }.navigationBarTitle(Text("Authentication").bold(),displayMode: .inline)
                .padding()
        }
    }
}
struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
// MARK: - Flexible Label with Image
struct FlexibleLabelWithImage: View {
    @State var button: APPButtons
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                Spacer()
                //                Image(systemName: button.image)
                //                    .renderingMode(.original)
                //                    .font(.system(size: 18))
                //                    .foregroundColor(.blue)
                Text(button.title)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    //.foregroundColor(.secondary)
                    .padding()
                Spacer()
            }
            //.background(Color.gray)
            //.cornerRadius(40)
        }
    }
}
