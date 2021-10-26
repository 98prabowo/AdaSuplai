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
        let locationServices = LocalDataServices(fileName: DataURL.regions)
        locationServices.readLocalFile { [weak self] (data: [Location]) in
            if let provinces = self?.getSpecificProvince(Provinces.jawaTimur, from: data) {
                self?.locations = provinces
            }
        }
    }
    
    private func getSpecificProvince(_ province: String, from data: [Location]) -> [String] {
        var result = [String]()
        for datum in data where datum.province == province {
            result = datum.city
        }
        return result
    }
}
