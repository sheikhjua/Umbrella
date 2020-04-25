//
//  UserView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI

struct UserView: View {
    @ObservedObject var userViewModel = UserViewModel()
    var body: some View {
        ZStack{
            if !self.userViewModel.isDataLoaded {
                GeometryReader { _ in
                    ActivityIndicatorView(isAnimating: true)
                        .configure { $0.color = .purple}
                        .padding()
                        .background(Color.gray.opacity(0.9))
                        .cornerRadius(100)
                }
            } else {
                HStack{
                    VStack{
                        HStack{
                            Text("\(userViewModel.userFirstName) \(userViewModel.userLastName)")
                            Spacer()
                        }
                        HStack{
                            Text("\(userViewModel.userPhoneNumber)")
                            Spacer()
                        }
                    }.padding()
                    Image(uiImage: userViewModel.image)
                        .resizable()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.blue)
                    )
                }.padding()
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
