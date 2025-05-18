//
//  TransactionListView.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import CoreData
import SwiftUI

struct TransactionListView: View {
    @FetchRequest var transactions: FetchedResults<Transaction>
    let onDeleteTransaction: (Transaction) -> Void

    init(request: NSFetchRequest<Transaction>, onDeleteTransaction: @escaping (Transaction) -> Void) {
        _transactions = FetchRequest(fetchRequest: request)
        self.onDeleteTransaction = onDeleteTransaction
    }

    var body: some View {
        if transactions.isEmpty {
            Text("No Transactions")
        } else {
            List {
                ForEach(transactions) { transaction in
                    HStack {
                        Text(transaction.title ?? "")
                        Spacer()
                        Text(
                            transaction.total as NSNumber,
                            formatter: NumberFormatter.currency)
                    }
                }
                .onDelete { offSets in
                    offSets.map { transactions[$0] }.forEach(onDeleteTransaction)
                }
            }
        }
    }
}
//
//#Preview {
//    TransactionListView()
//}
