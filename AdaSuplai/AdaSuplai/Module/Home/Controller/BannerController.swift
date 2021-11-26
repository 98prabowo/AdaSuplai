//
//  BannerController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 26/11/21.
//

import UIKit

class BannerController: BaseUIViewController {
    private enum Constant {
        static let header = "Promotion"
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: BannerViewModel
    
    init(with banners: Banner) {
        self.viewModel = BannerViewModel(with: banners)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupTable()
    }
    
    private func setupNavigationBar() {
        self.addBackButton()
        self.title = Constant.header
        guard let navigation = self.navigationController else { return }
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.barTintColor = .white
        navigation.navigationBar.tintColor = .primaryGreen
    }
    
    private func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(forCell: ImageBannerCell.self)
        self.tableView.registerNib(forCell: DescriptionCell.self)
    }
}

extension BannerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withCell: ImageBannerCell.self, for: indexPath)
            if let image = self.viewModel.banner.image {
                cell.configure(with: image)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withCell: DescriptionCell.self, for: indexPath)
            cell.configure(with: self.viewModel.banner.description)
            return cell
        }
    }
}
