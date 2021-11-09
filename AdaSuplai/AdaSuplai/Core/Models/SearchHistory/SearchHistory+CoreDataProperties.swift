//
//  SearchHistory+CoreDataProperties.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/11/21.
//
//

import Foundation
import CoreData

extension SearchHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchHistory> {
        return NSFetchRequest<SearchHistory>(entityName: "SearchHistory")
    }

    @NSManaged public var searchKey: String?
    @NSManaged public var date: Date?

}

extension SearchHistory: Identifiable {

}
