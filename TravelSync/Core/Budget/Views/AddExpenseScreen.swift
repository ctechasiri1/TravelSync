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
        
        ScrollView {
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
                    Text("CATEGORY")
                        .font(.system(.subheadline, weight: .semibold))
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
                
                Group {
                    CustomDatePicker(selectedDate: $budgetViewModel.transactionDate, pickerTitle: "TRANSACTION DATE")
                    
                    InputTextField(text: $budgetViewModel.notes, fieldTitle: "EXPENSE NOTSE", fieldImage: "pencil.and.list.clipboard", fieldContent: "Dinner at the Habor...", iconColor: .secondaryText)
                    
                    ReceiptUploadButton {
                            
                    }
                    .padding(.vertical)
                    
                    AuthButton(text: "Confirm Transaction", foregroundColor: .white, backgroundColor: .accentPrimary) {
                    }
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
                
                
                Spacer()
            }
        }
    }
}

private struct ExpenseOptionButton: View {
    let expense: ExpenseOption
    let isSelected: Bool
    
    var body: some View {
        VStack {
            SquareIcon(
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
        .padding(5)
    }
}

private struct ReceiptUploadButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ATTACH RECEIPT")
                .foregroundStyle(Color.primaryText)
                .font(.system(size: 15, weight: .semibold))
                .padding(.leading, 5)
            
            Button {
                action()
            } label: {
                VStack {
                    Image(systemName: "camera.fill")
                        
                    Text("Upload Image")
                }
                .frame(maxWidth: .infinity, minHeight: 150)
                .foregroundStyle(.secondaryText.opacity(0.6))
                .background(.gray.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [8]))
                        .foregroundStyle(.secondaryText.opacity(0.2))
                }
            }
        }
    }
}

#Preview {
    AddExpenseScreen()
        .environment(AppState())
}
