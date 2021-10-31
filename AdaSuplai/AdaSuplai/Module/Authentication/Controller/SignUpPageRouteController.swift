//
//  SignUpController.swift
//  AdaSuplai
//
//  Created by Felicia Devina on 25/10/21.
//

import UIKit

class SignUpPageRouteController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    @IBOutlet weak var pageControll: UIPageViewController!
    
    var dataSources = [SignUpController(), AccountInformationController(), OTPController()]
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = .clear
        return pageControl
    }()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        view.addSubview(pageControl)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.frame = CGRect(x: 10, y: view.frame.height-100, width: view.frame.width, height: 70)
    }
    
    func configurePageViewController() {
        dataSource = self
        delegate = self
        
        if let firstView = dataSources.first {
            self.setViewControllers([firstView], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = dataSources.firstIndex(of: viewController) else { return nil }
        let previous = vcIndex - 1
        guard previous >= 0 else { return nil }
        return dataSources[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = dataSources.firstIndex(of: viewController) else { return nil }
        let next = vcIndex + 1
        guard dataSources.count != next else { return nil }
        guard dataSources.count >  next else { return nil }
        return dataSources[next]
    }
    
}
