//
//  ContentView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/16.
//

import SwiftUI
import CoreData

enum SheetAction: Identifiable {
    case add
    case edit(BudgetCategory)
    
    var id: Int {
        switch self {
        case .add:
            return 1
        case .edit(_):
            return 2
        }
    }
    
}

struct BudgetListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: BudgetCategory.all) var budgetCategoryResults
    
    @State private var sheetAction: SheetAction?

    
    var totalBudget: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            result + budgetCategory.total
        }
    }
    
    private func deleteBudgetCategory(budgetCategory: BudgetCategory) {
        viewContext.delete(budgetCategory)
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    private func editBudgetCategory(budgetCategory: BudgetCategory) {
        sheetAction = .edit(budgetCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Total: \(totalBudget as NSNumber, formatter: NumberFormatter.currency)")
                    .bold()
                BudgetListViewCell(budgetCategoryResults: budgetCategoryResults,
                                   onDeleteBudgetCategory: deleteBudgetCategory, onEditBudgetCategory: editBudgetCategory)
            }
            .sheet(item: $sheetAction, content: { sheetAction in
                switch sheetAction {
                case .add:
                    AddBudgetCategoryView()
                case .edit(let budgetCategory):
                    AddBudgetCategoryView(budgetCategory: budgetCategory)
                }
            })
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category") {
                        sheetAction = .add
                    }
                }
            }
        }
    }
}

#Preview {
    BudgetListView()
        .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
}
