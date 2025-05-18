//
//  TransactionListView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import SwiftUI
import CoreData

struct TransactionListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    
    init(request: NSFetchRequest<Transaction>) {
        _transactions = FetchRequest(fetchRequest: request)
    }
    
    var body: some View {
        if transactions.isEmpty {
            Text("No Transactions")
        } else {
            List(transactions) { transaction in
                HStack {
                    Text(transaction.title ?? "")
                    Spacer()
                    Text(transaction.total as NSNumber, formatter: NumberFormatter.currency)
                }
            }
        }
    }
}
//
//#Preview {
//    TransactionListView()
//}
