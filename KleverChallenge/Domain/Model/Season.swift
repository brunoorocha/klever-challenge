//
//  Season.swift
//  KleverChallenge
//
//  Created by Bruno Rocha on 07/12/23.
//

import Foundation

enum Season: String {
    case winter
    case spring
    case summer
    case fall
}

extension Season {
    static var current: Season {
        let currentMonth = Calendar.current.component(.month, from: .now)
        return seasonFor(month: currentMonth)
    }
    
    static func seasonFor(month: Int) -> Season {
        switch month {
        case 4...6:
            return .spring
        case 7...9:
            return .summer
        case 10...12:
            return .fall
        default:
            return .winter
        }
    }
}
