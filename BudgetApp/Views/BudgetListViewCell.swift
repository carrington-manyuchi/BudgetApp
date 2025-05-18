//
//  BudgetListView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI

struct BudgetListViewCell: View {
    let budgetCategoryResults: FetchedResults<BudgetCategory>
    let onDeleteBudgetCategory: (BudgetCategory) -> Void
    
    var body: some View {
        List {
            if !budgetCategoryResults.isEmpty {
                ForEach(budgetCategoryResults) { budgetCategory in
                    NavigationLink(value: budgetCategory) {
                        HStack {
                            Text(budgetCategory.title ?? "")
                            Spacer()
                            VStack {
                                Text(budgetCategory.total as NSNumber, formatter: NumberFormatter.currency)
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { budgetCategoryResults[$0] }
                        .forEach(onDeleteBudgetCategory)
                }
            } else {
                Text("No budget categories exists")
            }
        }
        .navigationDestination(for: BudgetCategory.self) { budgetCategory in
            BudgetDetailView(budgetCategory: budgetCategory)
        }
    }
}
