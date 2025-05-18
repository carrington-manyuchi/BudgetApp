//
//  AddBudgetCategoryView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var total : Double = 100
    @State private  var messages: [String] = []
    @State private var budgetCategory: BudgetCategory?
    
    init(budgetCategory: BudgetCategory? = nil) {
        self.budgetCategory = budgetCategory
    }
    
    var isFormValid: Bool {
        messages.removeAll()
        if title.isEmpty {
            messages.append("Title is required")
        }
        
        if total <= 0 {
            messages.append("Total must be greater than R1")
        }
        return messages.count == 0
    }
    
//    private func saveBudget() {
//        let budgetCategory = BudgetCategory(context: viewContext)
//        budgetCategory.title = title
//        budgetCategory.total = total
//        
//        do {
//            try viewContext.save()
//            dismiss()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    //last part
    private func saveOrUpdate() {
//        if let budgetCategory = budgetCategory {
//            budgetCategory.setValue(title, forKey: "title")
//            budgetCategory.setValue(total, forKey: "total")
//        } else {
//            saveBudget()
//        }
        
        if let budgetCategory {
            let budget = BudgetCategory.byID(budgetCategory.objectID)
            budget.title = title
            budget.total = total
        } else {
            let budget = BudgetCategory(context: viewContext)
            budget.title = title
            budget.total = total
        }
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                Slider(value: $total, in: 0...500, step: 50) {
                    Text("Total")
                } minimumValueLabel: {
                    Text("R0")
                } maximumValueLabel: {
                    Text("R500")
                }
                
                Text(total as NSNumber, formatter: NumberFormatter.currency)
                    .centerHorizontally()
                
                ForEach(messages, id: \.self) { message in
                    Text(message)
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            .onAppear(perform: {
                if let budgetCategory {
                    title = budgetCategory.title ?? ""
                    total = budgetCategory.total
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        //MARK: - TODO
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //MARK: - TODO
                        if isFormValid {
                           // saveBudget()
                            saveOrUpdate() // lastPart
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}
