//
//  FilterViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/10/21.
//

import Foundation

class FilterViewModel: BaseViewModel {
    var locations = [String]()
    
    override init() {
        super.init()
        self.fetchLocations()
    }
    
    private func fetchLocations() {
        do {
            let data = try LocalDataService().readFile([Location].self, from: .regions)
            self.locations = self.getSpecificProvince(.jawaTimur, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getSpecificProvince(_ province: Province, from data: [Location]) -> [String] {
        var result = [String]()
        for datum in data where datum.province == province.rawValue {
            result = datum.city
        }
        return result
    }
}
