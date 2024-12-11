//
//  T2_DAMIIApp.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import SwiftUI

@main
struct T2_DAMIIApp: App {
    let persistence = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListaProductosView()
                .environment(
                    \.managedObjectContext,
                     persistence.container.viewContext
                )
        }
    }
}
