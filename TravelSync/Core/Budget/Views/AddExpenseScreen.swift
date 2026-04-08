//
//  AddExpenseScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import SwiftUI

struct AddExpenseScreen: View {
    @Environment(AppState.self) private var appState
    @State private var textWidth = CGFloat.zero
    
    var body: some View {
        @Bindable var budgetViewModel = appState.budget
        
        VStack {
            SheetToolbar(title: "Add Expense", enableSave: true) {
                
            }
            VStack(alignment: .center) {
                Text("AMOUNT")
                    .foregroundStyle(.gray.opacity(0.6))
                    .font(.system(.subheadline, weight: .semibold))
                
                
                TextField("$0.00", text: $budgetViewModel.expenseAmount)
                    .font(.system(size: 50, weight: .semibold))
                    
                    .frame(width: textWidth)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background {
                        Text(
                            budgetViewModel.expenseAmount.isEmpty ? "$0.00" : budgetViewModel.expenseAmount
                        )
                        .fixedSize()
                        .hidden()
                        .padding(50)
                        .onGeometryChange(for: CGFloat.self) { proxy in
                            proxy.size.width
                        } action: { newVal in
                            textWidth = newVal
                        }
                    }
            }
            .padding()
            
            VStack(alignment: .leading) {
                Text("Category")
                    .font(.system(.title2, weight: .semibold))
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(ExpenseOption.allCases) { expense in
                            Button {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    budgetViewModel.selectedExpense = expense
                                }
                            } label: {
                                ExpenseOptionButton(expense: expense, isSelected: budgetViewModel.selectedExpense == expense)
                                    .padding(.vertical)
                            }
                            
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
    let isSelected: Bool
    
    var body: some View {
        VStack {
            CircleIcon(
                iconName: expense.imageName,
                iconColor: isSelected ? expense.color : .secondaryText
                    .opacity(0.5),
                width: 50,
                height: 50
            )
            .padding()
                
            Text(expense.title)
                .foregroundStyle(
                    isSelected ? expense.color : .secondaryText.opacity(0.5)
                )
                .font(.system(size: 12, weight: .semibold))
                .padding(.vertical, 5)
        }
        .padding()
        .createCardBackgroud()
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .fill(.clear)
                .strokeBorder(
                    isSelected ? expense.color : .secondaryText.opacity(0.5),
                    lineWidth: 0.6
                )
        }
    }
}

private struct DatePicker: View {
    var body: some View {

    }
}

#Preview {
    AddExpenseScreen()
        .environment(AppState())
}
