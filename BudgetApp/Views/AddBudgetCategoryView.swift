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
                    }
                }
                
            }
        }
    }
}

#Preview {
    AddBudgetCategoryView()
}
