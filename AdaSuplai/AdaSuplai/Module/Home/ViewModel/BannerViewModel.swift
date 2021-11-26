//
//  BannerViewModel.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import Foundation

class BannerViewModel: BaseViewModel {
    let banner: Banner
    
    init(with banner: Banner) {
        self.banner = banner
        super.init()
    }
}
