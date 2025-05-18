//
//  BudgetCategory+CoreDataClass.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import Foundation
import CoreData

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    var overSpent: Bool {
        remainingBudgetTotal < 0
    }
    
    var transactionsTotal: Double {
        transactionsArray.reduce(0) { result, transaction in
            result + transaction.total
        }
    }
    
    var remainingBudgetTotal: Double {
        self.total - transactionsTotal
    }
    
    static var all: NSFetchRequest<BudgetCategory> {
        let request = BudgetCategory.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        return request
    }
    
    private var transactionsArray: [Transaction] {
        guard let transactions = transactions else { return [] }
        let allTransactions = (transactions.allObjects as? [Transaction]) ?? []
        return allTransactions.sorted { t1, t2 in
            t1.dateCreated! > t2.dateCreated!
        }
    }
    
    static func byID(_ id: NSManagedObjectID) -> BudgetCategory {
        let vc = CoreDataManager.shared.viewContext
        guard let budgetCategory = vc.object(with: id) as? BudgetCategory else {
            fatalError("Could not find BudgetCategory with ID \(id)")
        }
        return budgetCategory
    }
    
    static func transactionsByCategoryRequest(_ budgetCategory: BudgetCategory) -> NSFetchRequest<Transaction> {
        let request = Transaction.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
        request.predicate = NSPredicate(format: "category == %@", budgetCategory)
        return request
    }
    
}
