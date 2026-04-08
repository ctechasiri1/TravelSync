//
//  AddExpenseScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import SwiftUI

struct AddExpenseScreen: View {
    var body: some View {
        VStack {
            SheetToolbar(title: "Add Expense", enableSave: true) {
                
            }
            
            Text("AMOUNT")
            
            VStack(alignment: .leading) {
                Text("Category")
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(ExpenseOption.allCases) { expense in
                            
                            ExpenseOptionButton(expense: expense)
                                .padding(.vertical)
                        }
                        .padding(.horizontal, 12)
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            Spacer()
        }
    }
}

private struct ExpenseOptionButton: View {
    let expense: ExpenseOption
    
    var body: some View {
        OptionsCard(title: "") {
            VStack {
                CircleIcon(
                    iconName: expense.imageName,
                    iconColor: expense.color,
                    width: 50,
                    height: 50
                )
                .padding()
                
                Text(expense.title)
                    .foregroundStyle(expense.color)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.vertical, 5)
            }
            .padding()
        }
    }
}

#Preview {
    AddExpenseScreen()
        .environment(AppState())
}
