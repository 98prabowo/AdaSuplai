//
//  Banner.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import Foundation
import UIKit

struct Banner {
    let image: UIImage?
    let description: String
}

class BannerData {
    private let bannerA = Banner(image: UIImage(named: "banner0"),
                                description: """
                                Special Deal! - Dapatkan promo spesial dari Coffee First sebesar 50% , khusus untuk pembelian pertamamu. Promo akan otomatis terpakai saat order. Kuota promosi terbatas jadi segera buat pesananmu!

                                Syarat & Kententuan:
                                Min. pembelian Rp. 850.000
                                Maks. potongan Rp. 100.000
                                """)
    private let bannerB = Banner(image: UIImage(named: "banner1"),
                                description: """
                                Special Deal! - Dapatkan promo spesial dari Coffee First sebesar 50% , khusus untuk pembelian pertamamu. Promo akan otomatis terpakai saat order. Kuota promosi terbatas jadi segera buat pesananmu!

                                Syarat & Kententuan:
                                Min. pembelian Rp. 850.000
                                Maks. potongan Rp. 100.000
                                """)
    private let bannerC = Banner(image: UIImage(named: "banner2"),
                                description: """
                                Special Deal! - Dapatkan promo spesial dari Coffee First sebesar 50% , khusus untuk pembelian pertamamu. Promo akan otomatis terpakai saat order. Kuota promosi terbatas jadi segera buat pesananmu!

                                Syarat & Kententuan:
                                Min. pembelian Rp. 850.000
                                Maks. potongan Rp. 100.000
                                """)
    func getBannerData() -> [Banner] {
        return [bannerA, bannerB, bannerC]
    }
}
