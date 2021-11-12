//
//  FilterViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import Foundation
import Combine

class FilterViewModel: BaseViewModel {
    let service: RemoteDataService
    var locations = [String]()
    var categories = CurrentValueSubject<[String], Never>([String]())
    
    override init() {
        self.service = RemoteDataService()
        super.init()
        self.fetchLocations()
        self.fetchCategory()
    }
    
    private func fetchLocations() {
        do {
            let data = try LocalDataService().readFile([Location].self, from: .regions)
            self.locations = self.getSpecificProvince(.jawaTimur, from: data)
        } catch {
            print("Fetch Locations in Filter error: \(error.localizedDescription)")
        }
    }
    
    private func getSpecificProvince(_ province: Province, from data: [Location]) -> [String] {
        var result = [String]()
        for datum in data where datum.province == province.rawValue {
            result = datum.city
        }
        return result
    }
    
    private func fetchCategory() {
        Task {
            do {
                let parent = try await service.getData(InitialCategory.self, url: .category)
                self.categories.value = parent.data.map { $0.name }
            } catch {
                print("Fetch Category in Filter error: \(error.localizedDescription)")
            }
        }
    }
}
