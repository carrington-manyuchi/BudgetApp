//
//  BudgetSummaryView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI

struct BudgetSummaryView: View {

    @ObservedObject var budgetCategory: BudgetCategory

    var body: some View {
        VStack {
            Text(
                "\(budgetCategory.overSpent ? "Overspent" : "Remaining") \(Text(budgetCategory.remainingBudgetTotal as NSNumber, formatter: NumberFormatter.currency))"
            )
            .frame(maxWidth: .infinity)
            .bold()
            .foregroundStyle(budgetCategory.overSpent ? .red : .green)
        }
    }
}
//
//#Preview {
//    BudgetSummaryView()
//}
