//
//  ReviewController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import UIKit

class ReviewController: BaseUIViewController {
    private enum Constant {
        static let header = "Review"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: ReviewViewModel
    
    init(with reviews: [Review]) {
        self.viewModel = ReviewViewModel(with: reviews)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupBackground()
        self.setupTable()
    }
    
    private func setupNavigationBar() {
        self.addBackButton()
        self.title = Constant.header
    }
    
    private func setupBackground() {
        self.tableView.backgroundColor = .blueBackground
    }
    
    private func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: ProductReviewDetailCell.self)
    }
}

extension ReviewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withCell: ProductReviewDetailCell.self, for: indexPath)
        let review = self.viewModel.reviews[indexPath.row]
        cell.configureReview(with: review)
        return cell
    }
}
