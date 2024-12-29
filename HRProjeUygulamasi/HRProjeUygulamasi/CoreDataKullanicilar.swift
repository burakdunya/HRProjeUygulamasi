//
//  CoreDataKullanicilar.swift
//  HRProjeUygulamasi
//
//  Created by Burak DÜNYA on 28.12.2024.
//


import CoreData
import Foundation

class KullanicilarDataController : ObservableObject {
    let container = NSPersistentContainer(name: "HRProjeUygulamasi")
    
    init() {
        container.loadPersistentStores { description, erro in
            if let erro {
                print("error while load persistent")
            }
        }
    }
}
