//
//  Transaction+CoreDataClass.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/18.
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {
    
    public override func awakeFromInsert() {
        self.dateCreated = Date()
    }
    
    
    
}
