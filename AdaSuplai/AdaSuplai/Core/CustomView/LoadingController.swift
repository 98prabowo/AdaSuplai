//
//  LoadingController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 05/11/21.
//

import Foundation
import  UIKit

class LoadingController {
    func createLoading(with message: String = "") -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        
        return alert
    }
}
