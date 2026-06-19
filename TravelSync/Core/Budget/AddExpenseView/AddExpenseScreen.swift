//
//  AddExpenseView.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/7/26.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var textWidth = 10.0
    @State private var viewModel: AddExpenseViewModel
    
    let trip: Trip
    
    init(viewModel: AddExpenseViewModel, trip: Trip) {
        _viewModel = State(wrappedValue: viewModel)
        self.trip = trip
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SheetToolBar(
                    title: "Add Expense",
                    enableSave: viewModel.enableSave
                ) {
                    Task {
                        await viewModel.createExpense(tripId: trip.id)
                        await MainActor.run {
                            dismiss()
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    Text("AMOUNT")
                        .foregroundStyle(.gray.opacity(0.6))
                        .font(.system(.subheadline, weight: .semibold))
                    
                    HStack(alignment: .center) {
                        Text("$")
                            .font(.system(size: 25, weight: .semibold))
                        
                        TextField(
                            "0",
                            text: $viewModel.expenseAmount,
                            axis: .horizontal
                        )
                        .font(.system(size: 50, weight: .semibold))
                        .textFieldStyle(PlainTextFieldStyle())
                        .fixedSize(horizontal: true, vertical: false)
                        .keyboardType(.decimalPad)
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("CATEGORY")
                        .font(.system(.subheadline, weight: .semibold))
                        .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(ExpenseOption.allCases) { expense in
                                ExpenseOptionButton(
                                    expense: expense,
                                    isSelected: viewModel.selectedExpense == expense) {
                                        viewModel.selectExpense(expense: expense)
                                    }
                                    .padding(.vertical, 5)
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            
                Group {
                    CustomDatePicker(
                        selectedDate: $viewModel.transactionDate,
                        pickerTitle: "TRANSACTION DATE")
                    .padding(.bottom)
                    
                    InputTextField(
                        text: $viewModel.notes,
                        fieldTitle: "EXPENSE NOTE",
                        fieldImage: "pencil.and.list.clipboard",
                        fieldContent: "Dinner at the Habor...",
                        iconColor: .secondaryText,
                        characterLimit: 22
                    )
                    .padding(.bottom)
                    
                    ReceiptUploadButton {
                            
                    }
                    .padding(.vertical)
                    
                    MultipurposeButton(
                        buttonText: "Confirm Transaction",
                        foregroundColor: .white,
                        backgroundColor: .accentPrimary
                    ) {
                        Task {
                            await viewModel.createExpense(tripId: trip.id)
                            await MainActor.run {
                                dismiss()
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .showLoading(isLoading: viewModel.isNetworkActive)
    }
}

private struct ExpenseOptionButton: View {
    let expense: ExpenseOption
    let isSelected: Bool
    let selectExpense: () -> Void
    
    var body: some View {
        Button {
            selectExpense()
        } label: {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    CircleIcon(
                        iconName: expense.imageName,
                        iconColor: isSelected ? .accentPrimary : .secondaryText
                            .opacity(0.5),
                        width: 40,
                        height: 40
                    )
                    .padding([.top, .leading, .trailing])
                    
                    Text(expense.title)
                        .foregroundStyle(
                            isSelected ? .accentPrimary : .secondaryText.opacity(0.5)
                        )
                        .font(.system(size: 12, weight: .semibold))
                        .padding(.top, 10)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 15)
            .createCardBackgroud()
        }
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
    AddExpenseView(
        viewModel: AddExpenseViewModel(
            expenseService: ExpenseService(
                networkService: NetworkRequestService(),
                keychainService: KeychainService()
            )
        ), trip: Trip.example
    )
}
