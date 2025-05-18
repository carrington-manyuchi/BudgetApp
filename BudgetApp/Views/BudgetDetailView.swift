//
//  BudgetDetailView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI
import CoreData

struct BudgetDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let budgetCategory: BudgetCategory
    
    @State private var title: String = ""
    @State private var total: String = ""
    @State private var messages: [String] = []
    
    var isFormValid: Bool {
        messages.removeAll()
        if title.isEmpty {
            messages.append("Title should not be empty")
            return false
        } else if title.count < 3 {
            messages.append("Title should be at least 3 characters long")
        }
        
        if total.isEmpty {
            messages.append("Total should not be empty")
            return false
        }
        
       guard let totalValue = Double(total) else {
            messages.append("Total should be a number")
            return false
        }
        
        if totalValue <= 0  {
            messages.append("Total should be greater than 0")
            return false
        }
        
        return messages.count == 0
    }
    
    private func saveTransaction() {
        let transaction = Transaction(context: viewContext)
        transaction.title = title
        transaction.total =  Double(total) ?? 0
        budgetCategory.addToTransactions(transaction)
        
        do {
            try viewContext.save()
            title = ""
            total = ""
        } catch {
            print(error)
        }
    }
    
    private func deleteTransaction(_ transaction: Transaction) {
        viewContext.delete(transaction)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text(budgetCategory.title ?? "")
                    .font(.largeTitle)
                
                Text("Budget: \(budgetCategory.total as NSNumber, formatter:NumberFormatter.currency)")
                    .bold()
            }
            
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Total", text: $total)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Add Transaction")
                        .bold()
                }
                
                Button("Save Transaction") {
                    if isFormValid {
                        saveTransaction()
                    }
                }
                .centerHorizontally()
                ForEach(messages, id: \.self) { message in
                    Text(message)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .frame(maxHeight: .infinity)
            
            //MARK: - Display summary of the budget category
            BudgetSummaryView(budgetCategory: budgetCategory)
            
            
            //MARK: - display the transaction
            TransactionListView(request: BudgetCategory.transactionsByCategoryRequest(budgetCategory), onDeleteTransaction: deleteTransaction)
            
        }
        .padding(.top, 30)
        Spacer()
    }
}

#Preview {
    BudgetDetailView(budgetCategory: BudgetCategory())
}
