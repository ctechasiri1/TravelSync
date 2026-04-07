//
//  BudgetScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import SwiftUI

struct BudgetScreen: View {
    let trip: Trip
    
    var body: some View {
        ScrollView {
            BudgetOverview(budget: trip.budget)
            
            Text("Expenses Breakdown")
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(ExpenseOption.allCases) { expenseType in
                ExpenseBreakdownOption(
                    title: expenseType.title,
                    iconName: expenseType.imageName,
                    iconColor: expenseType.color
                )
            }
        }
        .navigationTitle("Budget Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ToolbarButton(imageName: "plus", foregroundColor: .white, backgroundColor: .accentPrimary) {
//                    tripsViewModel.showPlanNewTrip = true
                }
            }
            .sharedBackgroundVisibility(.hidden)
        }
    }
}

private struct BudgetOverview: View {
    let budget: String
    
    var body: some View {
        OptionsCard(title: "") {
            HStack {
                VStack(alignment: .leading) {
                    Text("Total Spend")
                        .foregroundStyle(.secondaryText)
                    
                    Text("$1,450.00")
                        .font(.system(.title, weight: .semibold))
                    
                    Text("of $\(budget) budget")
                        .foregroundStyle(.secondaryText)
                    
                    LinearProgressBar(value: 0.1, shape: RoundedRectangle(cornerRadius: 20))
                        .tint(.accentPrimary)
                        .frame(height: 15)
                        .padding(.vertical)
                    
                    HStack {
                        HStack {
                            Image(systemName: "calendar")
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Daily Avg")
                                
                                Text("$185")
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity)
                        
                        HStack {
                            Image(systemName: "dollarsign")
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Left")
                                
                                Text("$185")
                            }
                            
                            Spacer()
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 20)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

private struct ExpenseBreakdownOption: View {
    let title: String
    let iconName: String
    let iconColor: Color
    
    var body: some View {
        OptionsCard(title: "") {
            HStack {
                SquareIcon(
                    iconName: iconName,
                    iconColor: iconColor,
                    width: 40,
                    height: 40
                )
                .padding()
                
                
                VStack(alignment: .leading) {
                    Text(title)
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .imageScale(.small)
                            .foregroundStyle(iconColor)
                        
                        Text("Transactions")
                    }
                    .font(.system(.subheadline))
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("$320.50")
                    Text("22%")
                }
            }
            .padding()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

#Preview {
    BudgetScreen(trip: Trip.example)
        .environment(AppState())
}
