//
//  BudgetViewModel.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 4/6/26.
//

import Observation
import Foundation

@Observable
class BudgetViewModel {
    var expenses: [Expense] = [] {
        didSet {
            updateSortedExpenses()
            getCategorySum()
            getExpenseGroupByDate()
        }
    }
    var sortedExpenses: [Expense] = []
    var categorySums: [String: Int] = [:]
    var expenseGroupByDate: [Date: [Expense]] = [:]
    var updatedTrip: Trip? = nil
    
    var showAddExpense: Bool = false
    var showAllExpense: Bool = false
    var isNetworkActive: Bool = false
    
    private let expenseService: ExpenseServiceProtocol
    private let tripsService: TripServiceProtocol
    
    init(expenseService: ExpenseServiceProtocol, tripService: TripServiceProtocol) {
        self.expenseService = expenseService
        self.tripsService = tripService
    }

    var transactionDateRange: Int {
        guard let recentExpenseDate = sortedExpenses.first?.transactionDate,
              let leastRecentExpenseDate = sortedExpenses.last?.transactionDate else {
            return 0
        }
        
        let daysInBetween = Int(recentExpenseDate.timeIntervalSince(leastRecentExpenseDate) / 86400)
        return daysInBetween
    }
    
    var recentExpenses: [Expense] {
        Array(sortedExpenses.prefix(4))
    }
    
    func toggleShowAllExpense() -> Void {
        showAllExpense = true
    }
    
    func toggleShowAddExpense() -> Void {
        showAddExpense = true
    }
    
    func updateSortedExpenses() -> Void {
        sortedExpenses = expenses.sorted { $0.transactionDate > $1.transactionDate }
    }
    
    func getCategorySum() -> Void {
        var categoryDict: [String: Int] = [:]
        
        for expense in expenses {
            categoryDict[expense.type.title, default: 0] += expense.amount
        }
        
        categorySums = categoryDict
    }
    
    func getExpenseGroupByDate() -> Void {
        let dateDict: [Date: [Expense]] = Dictionary(grouping: expenses) { Calendar.current.startOfDay(for: $0.transactionDate) }
        
        expenseGroupByDate = dateDict
    }
    
    func getCategorySum(categoryType: String) -> String {
        guard let categorySum = categorySums[categoryType] else {
            return "0"
        }
        return Double(categorySum).toString
    }
    
    func getTrip(tripId: Int) async -> Void {
        do {
            let tripPayload = try await tripsService.getTrip(tripId: tripId)
            await MainActor.run {
                updatedTrip = Trip(
                    id: tripPayload.id,
                    tripName: tripPayload.tripName,
                    location: tripPayload.location,
                    longitude: tripPayload.longitude,
                    latitude: tripPayload.latitude,
                    budget: tripPayload.budget,
                    totalSpending: tripPayload.totalSpending,
                    isFavorite: tripPayload.isFavorite,
                    startDate: tripPayload.startDate,
                    endDate: tripPayload.endDate,
                    imageURLString: tripPayload.imageURL
                )
            }
        }  catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }

    func getExpenses(tripId: Int) async -> Void {
        do {
            var fetchedExpenses: [Expense] = []
            let expensePayload = try await expenseService.getExpenses(tripId: tripId)
            await getTrip(tripId: tripId)
            await MainActor.run {
                for expenseDTO in expensePayload {
                    let expenseDomain = Expense(
                        id: expenseDTO.id,
                        title: expenseDTO.title,
                        amount: expenseDTO.amount,
                        transactionDate: expenseDTO.transactionDate,
                        type: ExpenseOption(fromRawValue: expenseDTO.categoryId)
                    )
                    fetchedExpenses.append(expenseDomain)
                    
                    self.expenses = fetchedExpenses
                }
            }
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
    
    func deleteExpense(tripId: Int, expenseId: Int) async {
        defer { isNetworkActive = false }
        
        isNetworkActive = true
        
        do {
            let _ = try await (Task.sleep(nanoseconds: 500_000_000), expenseService.deleteExpense(tripId: tripId, expenseId: expenseId))
            await getExpenses(tripId: tripId)
        } catch let error as APIError {
            print("There was a network error: \(error).")
        } catch {
            print("There was an unexpected error.")
        }
    }
}
