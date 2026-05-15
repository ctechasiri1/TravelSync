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
    let trip: Trip
    
    init(viewModel: BudgetViewModel, trip: Trip) {
        _viewModel = State(wrappedValue: viewModel)
        self.trip = trip
    }
    var body: some View {
        List {
            ForEach(viewModel.expenseGroupByDate.keys.sorted(by: >), id: \.self) { date in
                Text(date.formattedNumericDate)
                    .padding(.horizontal, 20)
                    .sectionTitleStyle()
                
                if let expenseList = viewModel.expenseGroupByDate[date] {
                    ForEach(Array(expenseList), id: \.self) { expense in
                        ExpenseItem(
                            title: expense.title,
                            amount: expense.amount,
                            transactionDate: expense.transactionDate,
                            type: expense.type
                        )
                        .swipeActions(edge: .trailing) {
                            CustomDeleteButton {
                                Task {
                                    await viewModel.deleteExpense(tripId: trip.id, expenseId: expense.id)
                                }
                            }
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .navigationTitle("All Expenses")
        .navigationBarTitleDisplayMode(.inline)
        .showLoading(isLoading: viewModel.isNetworkActive)
    }
}

private struct ExpenseItem: View {
    let title: String
    let amount: Int
    let transactionDate: Date
    let type: ExpenseOption
    
    var body: some View {
        HStack {
            CircleIcon(
                iconName: type.imageName,
                iconColor: type.color,
                width: 40,
                height: 40
            )
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                HStack {
                    Text(transactionDate.formatDate)
                    
                    Circle()
                        .frame(width: 5, height: 5)
                        .imageScale(.small)
                    
                    Text(type.title)
                }
                .foregroundStyle(.secondaryText)
                .font(.system(size: 12))
            }
            
            Spacer()
            
            Text("-$" + Double(amount).toString)
                .font(.system(size: 16, weight: .semibold))
        }
        .padding()
        .createCardBackgroud()
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}

#Preview {
    AllExpenseScreen(viewModel: BudgetViewModel(tripId: 1, expenseService: ExpenseService(networkService: NetworkRequestService(), keychainService: KeychainService())), trip: Trip.example)
        .environment(AppState())
}
