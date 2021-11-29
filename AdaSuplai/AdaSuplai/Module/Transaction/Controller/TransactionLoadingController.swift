//
//  TransactionLoadingController.swift
//  AdaSuplai
//
//  Created by Dimas A. Prabowo on 29/11/21.
//

import UIKit
import Combine

class TransactionLoadingController: BaseUIViewController {
    @IBOutlet private weak var loadingImage: UIImageView!
    
    private var viewModel: TransactionLoadingViewModel
    private var subscribers = Set<AnyCancellable>()
    
    init(with transaction: Transaction) {
        self.viewModel = TransactionLoadingViewModel(with: transaction)
        super.init(nibName: Self.identifier, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBackground()
        self.setupLoadingImage()
        self.postData()
        self.bindViewModel()
    }
    
    private func setupBackground() {
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .blueBackground
    }
    
    private func setupLoadingImage() {
        let loadingGIF = UIImage.gifImageFromAsset("waiting")
        self.loadingImage.image = loadingGIF
    }
    
    private func postData() {
        self.viewModel.postTransaction()
    }
    
    private func bindViewModel() {
        self.viewModel.transactionResponse
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] responses in
                if let response = responses.first {
                    self.viewModel.deleteCartData()
                    self.goToWaitingPayment(with: response)
                }
            }.store(in: &subscribers)
    }
    
    private func goToWaitingPayment(with data: TransactionResponse) {
        guard let navigation = self.navigationController,
        let payment = self.viewModel.transaction.payment else { return }
        let nextVC = WaitingPaymentController(with: data, and: payment)
        navigation.pushViewController(nextVC, animated: true)
    }
}
