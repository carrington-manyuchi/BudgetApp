//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Manyuchi, Carrington C on 2025/05/16.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
