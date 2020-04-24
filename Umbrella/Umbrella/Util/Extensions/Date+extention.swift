//
//  Date+extention.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
import SwiftUI
extension Date{
    func getYear()->String{
        let date = Date()
        let calender = Calendar.current
        return "\(calender.component(.year, from: date))"
    }
}
