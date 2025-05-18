//
//  AddBudgetCategoryView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI

struct AddBudgetCategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var title: String = ""
    @State private var total : Double = 100
    @State private  var messages: [String] = []
    
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
    
    private func saveBudget() {
        let budgetCategory = BudgetCategory(context: viewContext)
        budgetCategory.title = title
        budgetCategory.total = total
        
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        //MARK: - TODO
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        //MARK: - TODO
                        if isFormValid {
                            saveBudget()
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
