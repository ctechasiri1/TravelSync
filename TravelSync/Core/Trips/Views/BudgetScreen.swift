//
//  BudgetScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/21/26.
//

import SwiftUI

struct BudgetScreen: View {
    let trip: Trip
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TotalSpendMenu()
                }
            }
        }
        
    }
}

private struct TotalSpendMenu: View {
    var body: some View {
        OptionsCard(title: "Total Spend") {
            
        }
    }
}

private struct ExpenseBreakDown: View {
    var body: some View {
        
    }
}

#Preview {
    BudgetScreen(trip: Trip.example)
        .environment(AppState())
}
