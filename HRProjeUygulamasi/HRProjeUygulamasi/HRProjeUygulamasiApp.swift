//
//  HRProjeUygulamasiApp.swift
//  HRProjeUygulamasi
//
//  Created by Burak DÜNYA on 28.12.2024.
//

import SwiftUI

@main
struct HRProjeUygulamasiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
