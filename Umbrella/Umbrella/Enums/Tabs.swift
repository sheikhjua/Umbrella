//
//  Tabs.swift
//  Umbrella
//
//  Created by Sheikh Ahmed on 23/04/2020.
//  Copyright © 2020 Sheikh Ahmed. All rights reserved.
//
// MARK:- All tabs in the APP
enum APPTabs: String{
    case home
    case admin
    case group
    case report
    case more
    var title: String {
        return self.rawValue.titleCase()
    }
    var selectedImage: String {
        switch self {
        case .home: return "house.fill"
        case .admin: return "wrench.fill"
        case .group: return "person.3.fill"
        case .report: return "doc.text.fill"
        case .more: return "circle.grid.2x2.fill"
        }
    }
    var tag: Int{
        switch self {
        case .home: return 0
        case .admin: return 1
        case .group: return 2
        case .report: return 3
        case .more: return 4
        }
    }
}

