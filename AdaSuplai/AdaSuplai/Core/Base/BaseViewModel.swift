//
//  BaseViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 30/09/21.
//

import Foundation
import UIKit
import CoreData

class BaseViewModel {
    /// CoreData context
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    /// Save item to CoreData.
    func saveData() {
        guard let context = self.context else { return }
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    /// Delete item in CoreData
    func deleteData(_ object: NSManagedObject) {
        guard let context = self.context else { return }
        context.delete(object)
        self.saveData()
    }
    
    /// Delete all records in specific entity of CoreData.
    ///
    /// - Parameters:
    ///   - entity: Entity name that will be reseted.
    func resetAllRecords(in entity: String) {
        guard let context = self.context else { return }
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Reset coredata error: \(error.localizedDescription)")
        }
    }
}
