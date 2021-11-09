//
//  Extension-UIImageView.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 08/11/21.
//

import Foundation
import UIKit

class CacheImage: UIImageView {
    private var imageCaches = NSCache<NSString, NSData>()
    
    func setImage(from url: String, with network: RemoteDataService, placeholder: UIImage? = UIImage(systemName: "photo.fill")) {
        self.image = placeholder
        if let imageData = imageCaches.object(forKey: url as NSString),
           let image = UIImage(data: imageData as Data) {
            self.image = image
            return
        }
        
        Task {
            do {
                let data = try await network.downloadData(url: url)
                self.image = UIImage(data: data)
                self.imageCaches.setObject(data as NSData, forKey: url as NSString)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
