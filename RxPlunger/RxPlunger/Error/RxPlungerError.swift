//
//  RxPlungerError.swift
//  RxPlunger
//
//  Created by Ellen J on 2022/10/30.
//

import Foundation

enum RxPlungerError: Error {
    case custom(String)
    
    var description: String {
        switch self {
        case .custom(let messege):
            return messege
        }
    }
}
