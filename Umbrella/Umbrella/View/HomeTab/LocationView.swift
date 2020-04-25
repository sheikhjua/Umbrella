//
//  LocationView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI
import CoreLocation

struct LocationView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    //@ObservedObject var userViewModel = UserViewModel.shared
    var body: some View {
        VStack{
      //      if userViewModel.isDataLoaded {
                Text("You current location is: ")
                HStack{
                    Text("Latitude : \(self.locationViewModel.userLatitude)")
                    Text("Longitude : \(self.locationViewModel.userLongitude)")
                }
            }
       // }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
