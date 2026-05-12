//
//  AllExpenseScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 5/11/26.
//

import SwiftUI

struct AllExpenseScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: BudgetViewModel
    
    init(viewModel: BudgetViewModel) {
        _viewModel = State(wrappedValue: viewModel)
    }
    var body: some View {
        SheetToolbar(
            title: "Add Expense",
            enableSave: viewModel.showAllExpense
        ) {

        }
    }
}

#Preview {
    AllExpenseScreen(viewModel: BudgetViewModel(tripId: 1, expenseService: ExpenseService(networkService: NetworkRequestService(), keychainService: KeychainService())))
}
