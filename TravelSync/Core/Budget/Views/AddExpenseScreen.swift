//
//  AddExpenseScreen.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import SwiftUI

struct AddExpenseScreen: View {
    @Environment(AppState.self) private var appState
    @State private var textWidth = 10.0
    @State private var viewModel: AddExpenseViewModel
    
    let trip: Trip
    
    init(trip: Trip, viewModel: AddExpenseViewModel) {
        _viewModel = State(wrappedValue: viewModel)
        self.trip = trip
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SheetToolbar(title: "Add Expense", enableSave: viewModel.enableSave) {

                }
                
                VStack(alignment: .center) {
                    Text("AMOUNT")
                        .foregroundStyle(.gray.opacity(0.6))
                        .font(.system(.subheadline, weight: .semibold))
                    
                    HStack {
                        Text("$")
                            .font(.system(size: 45, weight: .semibold))
                        
                        TextField("0.00", text: $viewModel.expenseAmount, axis: .horizontal)
                            .font(.system(size: 50, weight: .semibold))
                            .textFieldStyle(PlainTextFieldStyle())
                            .fixedSize(horizontal: true, vertical: false)
                            .keyboardType(.numberPad)
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
                                        viewModel.selectedExpense = expense
                                    }
                                } label: {
                                    ExpenseOptionButton(expense: expense, isSelected: viewModel.selectedExpense == expense)
                                        .padding(.vertical, 5)
                                }
                            }
                            .padding(.horizontal, 12)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
                Group {
                    CustomDatePicker(selectedDate: $viewModel.transactionDate, pickerTitle: "TRANSACTION DATE")
                        .padding(.bottom)
                    
                    InputTextField(text: $viewModel.notes, fieldTitle: "EXPENSE NOTSE", fieldImage: "pencil.and.list.clipboard", fieldContent: "Dinner at the Habor...", iconColor: .secondaryText)
                        .padding(.bottom)
                    
                    ReceiptUploadButton {
                            
                    }
                    .padding(.vertical)
                    
                    MultipurposeButton(text: "Confirm Transaction", foregroundColor: .white, backgroundColor: .accentPrimary) {
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
                .frame(maxWidth: .infinity, minHeight: 160)
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
    AddExpenseScreen(trip: Trip.example, viewModel: AddExpenseViewModel(expenseService: ExpenseService(networkService: NetworkRequestService(), keychainService: KeychainService())))
        .environment(AppState())
}
