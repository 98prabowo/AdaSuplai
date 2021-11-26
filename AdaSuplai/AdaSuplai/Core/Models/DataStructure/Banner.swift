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
    var dummy = [
        Banner(image: UIImage(named: "banner0"),
               description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque id risus vel lectus elementum elementum."),
        Banner(image: UIImage(named: "banner1"),
               description: "Sed a tortor porta diam rhoncus pretium et id dolor. Donec tristique risus commodo, sodales arcu quis, varius velit. "),
        Banner(image: UIImage(named: "banner2"),
               description: "Mauris quis metus accumsan, finibus libero at, pretium libero. Nullam ac sem non lectus viverra commodo at nec est. ")
    ]
}
