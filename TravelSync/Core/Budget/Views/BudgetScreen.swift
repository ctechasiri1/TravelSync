//
//  BudgetScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import SwiftUI

struct BudgetScreen: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: BudgetViewModel
    @Binding var trip: Trip
    
    init(viewModel: BudgetViewModel, trip: Binding<Trip>) {
        _viewModel = State(wrappedValue: viewModel)
        _trip = trip
    }
    
    var body: some View {
        ScrollView {
            BudgetOverview(budget: trip.budget, totalSpend: trip.totalSpending, avgSpend: dailyAvgExpense())
            
            Text("Expenses Breakdown")
                .padding()
                .font(.system(.title2, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: .infinity)), GridItem(.flexible(minimum: 100, maximum: .infinity))], spacing: 15) {
                ForEach(ExpenseOption.allCases) { expenseType in
                    ExpenseBreakdownOption(
                        title: expenseType.title,
                        iconName: expenseType.imageName,
                        iconColor: expenseType.color,
                        amount: viewModel.getCategorySum(categoryType: expenseType.title),
                        totalSpend: trip.budget
                    )
                }
            }
            .padding(.horizontal)
            
            if !viewModel.expenses.isEmpty {
                HStack {
                    Text("Recent Activity")
                        .padding()
                        .font(.system(.title2, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        viewModel.showAllExpense = true
                    } label: {
                        HStack {
                            Text("View All")
                            
                            Image(systemName: "arrow.up.forward.app")
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .foregroundStyle(.secondaryText)
                        .font(.system(size: 14, weight: .semibold))
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .padding(.horizontal)
                }
                
                RecentActivities(expenses: Array(viewModel.sortedExpenses.prefix(4)))
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Budget Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getExpenses(tripId: trip.id)
        }
        .onChange(of: viewModel.updatedTrip ?? trip, { oldValue, newValue in
            trip = newValue
        })
        .navigationDestination(isPresented: $viewModel.showAllExpense, destination: {
            AllExpenseScreen(viewModel: viewModel, trip: $trip)
        })
        .fullScreenCover(isPresented: $viewModel.showAddExpense, onDismiss: {
            Task {
                await viewModel.getExpenses(tripId: trip.id)
            }
        }, content: {
            AddExpenseScreen(viewModel: appState.makeAddExpenseViewModel(), trip: trip)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarAddButton {
                    viewModel.showAddExpense = true
                }
                .imageScale(.medium)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func dailyAvgExpense() -> Int {
        let secondsBetween = Date.now.timeIntervalSince(trip.startDate)
        return Int(secondsBetween / 86400)
    }
}

private struct BudgetOverview: View {
    let budget: Int
    let totalSpend: Int
    let avgSpend: Int
    
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
                    
                Text("$\(totalSpend)")
                    .font(.system(.largeTitle, weight: .bold))
                    
                Text("of $\(budget) budget")
                    .foregroundStyle(.secondaryText)
                    
                LinearProgressBar(
                    value: Double(totalSpend) / Double(budget),
                    shape: RoundedRectangle(cornerRadius: 20)
                )
                .tint(.accentConfirmation)
                .frame(height: 15)
                .padding(.vertical)
                    
                ExpenseSummary(budget: budget, totalSpend: totalSpend, avgSpend: avgSpend)
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
    let budget: Int
    let totalSpend: Int
    let avgSpend: Int
    
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
                    
                    Text("\(avgSpend >= 0 ? avgSpend : 0)")
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
                    
                    Text("\(budget - totalSpend)")
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
    let amount: Int
    let totalSpend: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                CircleIcon(
                    iconName: iconName,
                    iconColor: iconColor,
                    width: 45,
                    height: 45
                )
                .padding()
                
                Spacer()
            }
            
            Text(title)
                .font(.system(size: 14))

            VStack(alignment: .leading, spacing: 5) {
                Text("$" + Double(amount).toString)
                    .font(.system(size: 18, weight: .semibold))
                
                Text((Double(amount) / Double(totalSpend)).toPercentage + "%")
                    .foregroundStyle(iconColor)
                    .font(.system(size: 12))
            }
        }
        .padding()
        .createCardBackgroud()
        .padding(.horizontal, 5)
    }
}

private struct RecentActivities: View {
    let expenses: [Expense]
    
    var body: some View {
        VStack {
            ForEach(expenses.sorted(by: { $0.amount > $1.amount })) { expense in
                HStack {
                    CircleIcon(
                        iconName: expense.type.imageName,
                        iconColor: .secondaryText,
                        width: 40,
                        height: 40
                    )
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(expense.title)
                            .font(.system(size: 16, weight: .semibold))
                        
                        HStack {
                            Text(expense.transactionDate.formatDate)
                            
                            Circle()
                                .imageScale(.small)
                                .frame(width: 5, height: 5)
                            
                            Text(expense.type.title)
                        }
                        .foregroundStyle(.secondaryText)
                        .font(.system(size: 12))
                    }
                    
                    Spacer()
                    
                    Text("-$" + Double(expense.amount).toString)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.vertical)
        }
        .padding()
        .createCardBackgroud()
    }
}

#Preview {
    BudgetScreen(viewModel: BudgetViewModel(expenseService: ExpenseService(networkService: NetworkRequestService(), keychainService: KeychainService()), tripService: TripService(networkService: NetworkRequestService(), keychainService: KeychainService())), trip: .constant(Trip.example))
        .environment(AppState())
}
