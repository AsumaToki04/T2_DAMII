//
//  Persistence.swift
//  T2_DAMII
//
//  Created by DAMII on 10/12/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "T2_DAMII")
        container.loadPersistentStores { _, error in
            if let er = error as? NSError {
                fatalError("No se pudo conectar con la BD: \(er)")
            }
        }
    }
}
