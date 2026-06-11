//
//  ExpenseOption.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import Foundation
import SwiftUI

enum ExpenseOption: Int, CaseIterable, Identifiable {
    case resturant, transport, shopping, activities
    
    init(fromRawValue: Int) {
        self = ExpenseOption(rawValue: fromRawValue) ?? .resturant
    }
    
    var id: Int { self.rawValue }
    
    var title: String {
        switch self {
        case .resturant:
            "Resturant"
        case .transport:
            "Transport"
        case .shopping:
            "Shopping"
        case .activities:
            "Activities"
        }
    }
    
    var imageName: String {
        switch self {
        case .resturant:
            "fork.knife"
        case .transport:
            "car.fill"
        case .shopping:
            "bag.fill"
        case .activities:
            "ticket.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .resturant:
            .accentBlue
        case .transport:
            .accentConfirmation
        case .shopping:
            .orange
        case .activities:
            .purple
        }
    }
}
