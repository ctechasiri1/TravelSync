//
//  BudgetScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import SwiftUI

struct BudgetScreen: View {
    @Environment(AppState.self) private var appState
    let trip: Trip
    
    var body: some View {
        @Bindable var budgetViewModel = appState.budget
        
        ScrollView {
            BudgetOverview(budget: trip.budget)
            
            Text("Expenses Breakdown")
                .padding()
                .font(.system(.title2, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(ExpenseOption.allCases) { expenseType in
                ExpenseBreakdownOption(
                    title: expenseType.title,
                    iconName: expenseType.imageName,
                    iconColor: expenseType.color
                )
            }
            
            Text("Recent Activity")
                .padding()
                .font(.system(.title2, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            RecentActivities(expenses: budgetViewModel.expenses)

            .padding(.horizontal)
        }
        .fullScreenCover(isPresented: $budgetViewModel.showAddExpense, content: {
            AddExpenseScreen()
        })
        .navigationTitle("Budget Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarButton(imageName: "plus", foregroundColor: .white, backgroundColor: .accentPrimary) {
                    budgetViewModel.showAddExpense = true
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}

private struct BudgetOverview: View {
    let budget: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Total Spend")
                        .foregroundStyle(.secondaryText)
                        
                    Spacer()
                        
                    Text("USD")
                        .foregroundStyle(.secondaryText)
                        .fontWeight(.semibold)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(
                            Capsule()
                                .strokeBorder(
                                    Color.gray.opacity(0.4),
                                    lineWidth: 0.3
                                )
                        )
                }
                    
                Text("$1,450.00")
                    .font(.system(.largeTitle, weight: .bold))
                    
                Text("of $\(budget) budget")
                    .foregroundStyle(.secondaryText)
                    
                LinearProgressBar(
                    value: 0.1,
                    shape: RoundedRectangle(cornerRadius: 20)
                )
                .tint(.accentConfirmation)
                .frame(height: 15)
                .padding(.vertical)
                    
                ExpenseSummary()
            }
            .padding()
                
            Spacer()
        }
        .padding()
        .createCardBackgroud()
        .padding()
    }
}

private struct ExpenseSummary: View {
    var body: some View {
        HStack(spacing: 20) {
            HStack {
                Image(systemName: "calendar")
                    .fontWeight(.bold)
                    .foregroundStyle(.accentBlue)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Daily Avg")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondaryText)
                    
                    Text("$185")
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(.gray.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
            
            HStack {
                Image(systemName: "dollarsign")
                    .fontWeight(.bold)
                    .foregroundStyle(.accentConfirmation)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Left")
                        .font(.system(size: 16))
                        .foregroundStyle(.secondaryText)
                    
                    Text("$185")
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(.gray.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
        }
    }
}

private struct ExpenseBreakdownOption: View {
    let title: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        HStack {
            SquareIcon(
                iconName: iconName,
                iconColor: iconColor,
                width: 50,
                height: 50
            )
            .padding()
                
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(.title3, weight: .semibold))
                    
                HStack {
                    Circle()
                        .imageScale(.small)
                        .frame(width: 10, height: 10)
                        .foregroundStyle(iconColor)
                        
                    Text("Transactions")
                        .foregroundStyle(.secondaryText)
                }
                .font(.system(.subheadline))
            }
            .padding(.horizontal, 8)
                
            Spacer()
                
            VStack(alignment: .trailing) {
                Text("$320.50")
                    .font(.system(.title3, weight: .semibold))
                    
                Text("22%")
                    .foregroundStyle(.secondaryText)
                    .font(.system(.subheadline))
            }
        }
        .padding()
        .createCardBackgroud()
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

private struct RecentActivities: View {
    let expenses: [Expense]
    
    var body: some View {
        ForEach(expenses) { expense in
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundStyle(expense.type.color)
                            
                    Rectangle()
                        .frame(width: 2)
                        .foregroundColor(.gray.opacity(0.3))
                }
                    
                VStack(alignment: .leading, spacing: 5) {
                    Text(expense.title)
                        .fontWeight(.semibold)
                        
                    HStack {
                        Text(expense.transactionDate.dateToDifferenceString())
                            
                        Circle()
                            .imageScale(.small)
                            .frame(width: 5, height: 5)
                            
                        Text(expense.type.title)
                    }
                    .foregroundStyle(.secondaryText)
                    .font(.system(.subheadline))
                }
                .padding(.horizontal)
                    
                Spacer()
                    
                Text("-$\(expense.amount)")
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
        }
        .padding()
        .createCardBackgroud()
    }
}

#Preview {
    BudgetScreen(trip: Trip.example)
        .environment(AppState())
}
