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
    
    var body: some View {
        VStack{
            Text("You current location is: ")
            HStack{
                Text("Latitude : \(self.locationViewModel.userLatitude)")
                Text("Longitude : \(self.locationViewModel.userLongitude)")
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
