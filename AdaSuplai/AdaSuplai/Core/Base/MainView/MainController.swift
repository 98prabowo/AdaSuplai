//
//  MainController.swift
//  AdaSuplai
//
//  Created by David Tandjung on 28/09/21.
//

import UIKit

class MainController: BaseUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nextVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: false, completion: nil)
    }

}
