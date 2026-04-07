//
//  ExpenseOption.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import Foundation
import SwiftUI

enum ExpenseOption: CaseIterable, Identifiable {
    case resturant, transport, shopping, hotel, activities
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .resturant:
            "Resturant"
        case .transport:
            "Transport"
        case .shopping:
            "Shopping"
        case .hotel:
            "Hotel"
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
        case .hotel:
            "bed.double.fill"
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
        case .hotel:
            .accentPrimary
        case .activities:
            .purple
        }
    }
}
