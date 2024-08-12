//
//  ProfileStatusEnum.swift
//  Task
//
//  Created by Sahitya on 12/08/24.
//

import Foundation

enum ProfileStatus: Int {
    case accepted, rejected
    
    init?(from string: String) {
        switch string.lowercased() {
        case "accepted":
            self = .accepted
        case "rejected":
            self = .rejected
        default:
            return nil
        }
    }
    
    var string: String {
        switch self {
        case .accepted:
            return "Accepted"
        case .rejected:
            return "Rejected"
        }
    }
}
