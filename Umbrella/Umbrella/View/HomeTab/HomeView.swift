//
//  HomeView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @State private var locationPermissionStatus: Bool = false
    var body: some View {
        ZStack{
            LocationView()
            VStack{
                UserView()
                Spacer()
            }
        }
        .onAppear {
            // self.handleLocationPermissionStatus()
        }
        .alert(isPresented: self.$locationPermissionStatus) {
            Alert(title: Text("APP needs permission to use your current location"),
                  message: Text("The permission is not allowed, please go to settings to change the settings"), primaryButton: .cancel(), secondaryButton: .default(Text("Settings")))
        }
    }
    func handleLocationPermissionStatus(){
        
        NotificationCenter.default.addObserver(forName: .locationAuthorizationStatusChanged, object: nil, queue: .main) { (_) in
            print("Permission not allowed....")
            self.locationPermissionStatus = true
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
