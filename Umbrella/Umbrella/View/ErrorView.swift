//
//  ErrorView.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 24/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("Error on loading data!!!")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
