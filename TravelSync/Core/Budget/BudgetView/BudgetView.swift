//
//  BudgetView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import SwiftUI

struct BudgetView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel: BudgetViewModel
    @Binding var trip: Trip
    
    init(viewModel: BudgetViewModel, trip: Binding<Trip>) {
        _viewModel = State(wrappedValue: viewModel)
        _trip = trip
    }
    
    var body: some View {
        ScrollView {
            BudgetSummaryView(
                budget: trip.budget,
                totalSpend: trip.totalSpending,
                avgSpend: dailyAvgExpense()
            )
            
            Text("Expenses Breakdown")
                .padding()
                .font(.system(.title2, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: .infinity)), GridItem(.flexible(minimum: 100, maximum: .infinity))], spacing: 15) {
                ForEach(ExpenseOption.allCases) { expenseType in
                    ExpenseBreakdownOptionView(
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
                RecentActivitiesView(recentExpenses: viewModel.recentExpenses) {
                    viewModel.toggleShowAllExpense()
                }
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
            AllExpenseView(viewModel: viewModel, trip: $trip)
        })
        .fullScreenCover(isPresented: $viewModel.showAddExpense, onDismiss: {
            Task {
                await viewModel.getExpenses(tripId: trip.id)
            }
        }, content: {
            AddExpenseView(viewModel: appState.makeAddExpenseViewModel(), trip: trip)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ToolBarAddButton {
                    viewModel.toggleShowAddExpense()
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func dailyAvgExpense() -> Int {
        if viewModel.transactionDateRange == 0 {
            return 0
        } else {
            return Int(trip.totalSpending / viewModel.transactionDateRange)
        }
    }
}

private struct BudgetSummaryView: View {
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
                    value: currentSpend(),
                    shape: RoundedRectangle(cornerRadius: 20)
                )
                .tint(.accentConfirmation)
                .frame(height: 15)
                .padding(.vertical)
                    
                BudgetMetericsView(
                    budget: budget,
                    totalSpend: totalSpend,
                    avgSpend: avgSpend
                )
            }
            .padding()
                
            Spacer()
        }
        .padding()
        .cardBackground()
        .padding()
    }
    
    private func currentSpend() -> Double {
        Double(totalSpend) / Double(budget)
    }
}

private struct BudgetMetericsView: View {
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
                        .font(.system(size: 15))
                        .foregroundStyle(.secondaryText)
                    
                    Text("$\(avgSpend)")
                        .fontWeight(.semibold)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(.gray.opacity(0.06))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(maxWidth: .infinity)
            
            HStack {
                Image(systemName: "banknote")
                    .fontWeight(.bold)
                    .foregroundStyle(.accentConfirmation)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Left")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondaryText)
                    
                    Text("$\(totalBdugetRemaining())")
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
    
    private func totalBdugetRemaining() -> Int {
        budget - totalSpend
    }
}

private struct RecentActivitiesView: View {
    let recentExpenses: [Expense]
    let showAllExpenseToggle: () -> Void
    
    var body: some View {
        HStack {
            Text("Recent Activity")
                .padding()
                .font(.system(.title2, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button {
                showAllExpenseToggle()
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
        
        VStack {
            ForEach(recentExpenses) { expense in
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
                            Text(expense.formattedTransactionDate)
                            
                            Circle()
                                .imageScale(.small)
                                .frame(width: 5, height: 5)
                            
                            Text(expense.type.title)
                        }
                        .foregroundStyle(.secondaryText)
                        .font(.system(size: 12))
                    }
                    
                    Spacer()
                    
                    Text("-$" + expense.amountString)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            .padding(.vertical)
        }
        .padding()
        .cardBackground()
        .padding(.horizontal)
    }
}

private struct ExpenseBreakdownOptionView: View {
    let title: String
    let iconName: String
    let iconColor: Color
    let amount: String
    let totalSpend: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                CircleIcon(
                    iconName: iconName,
                    iconColor: iconColor,
                    width: 40,
                    height: 40
                )
                .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 12))
                    
                    Text("$" + amount)
                        .font(.system(size: 16, weight: .semibold))
                }
                
                Spacer()
            }
        }
        .padding()
        .cardBackground()
        .padding(.horizontal, 5)
    }
}

#Preview {
    BudgetView(
        viewModel: BudgetViewModel(
            expenseService: ExpenseService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            ),
            tripService: TripService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            )
        ),
        trip: .constant(Trip.example)
    )
    .environment(AppState())
}
