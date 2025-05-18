//
//  ContentView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/16.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var budgetCategoryResults: FetchedResults<BudgetCategory>
    @State private var isPresented: Bool = false
    
    var totalBudget: Double {
        budgetCategoryResults.reduce(0) { result, budgetCategory in
            result + budgetCategory.total
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Total: \(totalBudget as NSNumber, formatter: NumberFormatter.currency)")
                    .bold()
                
                BudgetListView(budgetCategoryResults: budgetCategoryResults)
            }
            .sheet(isPresented: $isPresented, content: {
                AddBudgetCategoryView()
            })
            .presentationDetents([.medium])
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Category") {
                        isPresented = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
